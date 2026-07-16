float[] xPositions;
float[] yPositions;
float[] sizes;
float[] speeds;
color[] palette;

void setup() {
  size(900, 600);
  pixelDensity(2);
  background(12, 14, 24);
  noStroke();

  int count = 120;
  xPositions = new float[count];
  yPositions = new float[count];
  sizes = new float[count];
  speeds = new float[count];
  palette = new color[count];

  for (int i = 0; i < count; i++) {
    xPositions[i] = random(width);
    yPositions[i] = random(height);
    sizes[i] = random(8, 36);
    speeds[i] = random(0.5, 2.5);
    palette[i] = color(random(100, 255), random(80, 220), random(120, 255), 90);
  }
}

void draw() {
  fill(12, 14, 24, 28);
  rect(0, 0, width, height);

  float mouseInfluence = dist(mouseX, mouseY, pmouseX, pmouseY);
  float orbit = map(mouseInfluence, 0, 250, 0.0, 1.0);

  for (int i = 0; i < xPositions.length; i++) {
    float dx = mouseX - xPositions[i];
    float dy = mouseY - yPositions[i];
    float distance = sqrt(dx * dx + dy * dy);

    if (distance < 220) {
      xPositions[i] += (dx / distance) * speeds[i] * 2.4;
      yPositions[i] += (dy / distance) * speeds[i] * 2.4;
    } else {
      xPositions[i] += sin(frameCount * 0.01 + i) * 0.35;
      yPositions[i] += cos(frameCount * 0.01 + i) * 0.35;
    }

    if (xPositions[i] < -sizes[i]) xPositions[i] = width + sizes[i];
    if (xPositions[i] > width + sizes[i]) xPositions[i] = -sizes[i];
    if (yPositions[i] < -sizes[i]) yPositions[i] = height + sizes[i];
    if (yPositions[i] > height + sizes[i]) yPositions[i] = -sizes[i];

    float pulse = 16 + 10 * sin(frameCount * 0.03 + i * 0.6);
    float size = sizes[i] + pulse * orbit;

    fill(palette[i]);
    ellipse(xPositions[i], yPositions[i], size, size);

    stroke(255, 180);
    strokeWeight(1);
    line(xPositions[i], yPositions[i], mouseX, mouseY);
    noStroke();
  }
}

void mousePressed() {
  background(12, 14, 24);
}
