int canvasLeftCornerX = 30;
int canvasLeftCornerY = 60;

void UI() {
  bar = new ControlP5(this, createFont("微软雅黑", 14));

  int barSize = 200;
  int barHeight = 20;
  int barInterval = barHeight + 10;

  bar.addSlider("originalHeight", 1, 600, 150, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("树干高度");
  bar.addSlider("originalWidth", 1, 200, 20, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("树干宽度");
  bar.addSlider("branchNumber", 1, 5, 2, canvasLeftCornerX, canvasLeftCornerY+barInterval*2, barSize, barHeight).setLabel("树枝数");
  bar.addSlider("bifurcationRadian", 0, PI, PI*1/3, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("分叉弧度");
  bar.addSlider("changeRate", 0.1, 0.8, 0.5, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("变化率");
  //bar.addSlider("twistPhase", -TWO_PI, TWO_PI, PI*2/3, canvasLeftCornerX, canvasLeftCornerY+barInterval*5, barSize, barHeight).setLabel("柱体扭曲相变");
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
