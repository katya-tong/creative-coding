/*
* @Author: bit2atom | SJTU-ChinaGold DesignIntelligence
* @Email:  zhanglliqun@gmail.com
* @Date:   2015-06-29 06:25:25
* @brief
* @Last Modified by:   bit2atommac2019
* @Last Modified time: 2022-10-10 10:01:09
* @detail
*/
import processing.pdf.*;
boolean recordPDF = false;

PImage img; 
float min_radius, max_radius; 
int xx;
void setup() 
{ 
  img = loadImage("xinliu.jpg"); 
  size(600,900,P2D); 
  background(255); 
  noStroke(); 
  smooth(); 
  min_radius = 1.0; 
  max_radius = width/15.0; 
  xx=width-1;
} 
 
void draw(){
    saveFrame();
    float radius = map(xx, 0, width, min_radius, max_radius); 
    int opacity = int(map(mouseY, 0, height, 0, 255)); 
    //Ensure nearly-constant area is drawn each time 
    int num_rects = round((5*max_radius*max_radius)/(radius*radius)); 
    for(int i = 0; i < num_rects; ++i) { 
      float theta = random(TWO_PI); 
      int x = int(random(img.width)); 
      int y = int(random(img.height)); 
      color c = img.get(x,y); 
      fill(c, opacity);
      pushMatrix();
        translate(x,y);
        rotate(theta);
        rect( -radius/2.0, -radius/2.0, radius, radius );
      popMatrix();
    }
    if(xx>1)xx=xx-1;
}
