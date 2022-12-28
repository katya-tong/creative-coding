int canvasLeftCornerX = 80;
int canvasLeftCornerY = 20;

void UI() {
  bar = new ControlP5(this, createFont("微软雅黑", 14));

  int barSize = 150;
  int barHeight = 20;
  int barInterval = barHeight + 10;

  bar.addSlider("opacity", 0, 255, 10, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("opacity");
  bar.addSlider("radius", 2, 60, 20, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("radius");
  bar.addSlider("noisePower", 0.001, 0.1, 0.01, canvasLeftCornerX, canvasLeftCornerY+barInterval*2, barSize, barHeight).setLabel("noisePower");
  bar.addSlider("s", 1, 50, 20, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("s");
  bar.addSlider("segmentLength", 1, 100, 20, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("segmentLength");
  bar.addSlider("lineWeightThrehold", 0.1, 0.9, 0.5, canvasLeftCornerX, canvasLeftCornerY+barInterval*5, barSize, barHeight).setLabel("lineWeightThrehold");
   bar.setAutoDraw(false);
}

void lightSettings() {
  lightSpecular(255, 255, 255);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  specular(200, 200, 200);
  shininess(15);
}

void UIShow() {
  cam.beginHUD();  
  lights();
  bar.draw();
  cam.endHUD();

  if (mouseX<400 && mouseY< height) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}
