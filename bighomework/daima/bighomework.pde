import processing.serial.*;           //导入serial库 
Serial port;   //实例化一个Serial对象 
import processing.pdf.*;
import controlP5.*;
import peasy.*;
import nervoussystem.obj.*;

final int maxIterations = 20;

ArrayList<Particle> particles;
int n, s=20,s0=20, maxR;
int indexImg = 0;

int originalHeight = 150;
int originalWidth = 20;
int branchNumber = 2;
float bifurcationRadian = PI*1/3;
float changeRate = 0.5;

float min_radius=2.0, max_radius=60.0; 
float radius=20.0,radius0=20.0;
int opacity =10,opacity0=10;
float noisePower = 0.01,noisePower0 = 0.01;

PeasyCam cam;
ControlP5 bar;

int sampleNum = 30000;
int noiseDivideIndex = 100;
float segmentLength = 20,segmentLength0 = 20;
float lineWeightThrehold = 0.5,lineWeightThrehold0 = 0.5;
int countNumOfLines;
int singleLineLength = 5;
float xOff = 0.0;
float yOff = 0.0;

PFont myFont;
PImage img0;
PImage[] img= new PImage[12];
int k=1;

int photonumber=1;

boolean savePDF;

void setup()
{
 // port= new Serial(this,"COM15",9600);    //初始化port（根据Arduino分配的端口号填写）
  size(900,600); 
  background(255);
  myFont=createFont("黑体",16);
  textFont(myFont);
  img[1] = loadImage("1.png");
  img[2] = loadImage("2.png");
  img[3] = loadImage("3.png");
  img[4] = loadImage("4.png");
  img[5] = loadImage("5.png");
  img[6] = loadImage("6.jpg");
  img0=img[1];
  image(img0,0,0);
  cam = new PeasyCam(this, 2000);
  
  n = 1000;
  s = 20;
  maxR = height/2;
  particles = new ArrayList<Particle>();
  
  noStroke();

  fill(204,102,0);
  rect(800,40,50,50,10);     //绘制矩形  按键换照片
  fill(255);
  text("change",801,60);
  text("photo",805,80);
  
  UI();
} 

void draw()
{   
  //if (savePDF) {
  //  beginRecord(PDF, "output/noise"+imageName+".pdf");
  //}

   noStroke();
  initUI();
 
  if(opacity0!=opacity || radius0!=radius){//像素处理
       drawPixelRect();
       opacity0=opacity;
       radius0=radius;
  }
  if(noisePower!=noisePower0 || s0!=s){
      drawParticle();
      noisePower0=noisePower;
      s0=s;
  }
  if(segmentLength!=segmentLength0 || lineWeightThrehold!=lineWeightThrehold0){
    drawnoisebrush();
    segmentLength0=segmentLength;
    lineWeightThrehold0=lineWeightThrehold;
  }
  UIShow();
} 

void mouseClicked()
{ 
  if((mouseX>=800)&(mouseX<=850)&(mouseY>=40)&(mouseY<=90))                                        //当鼠标在矩形区域内单击时
    { 
    println("change photo");
    k=k+1;
    if(k>6) k=1;
    img0=img[k];
    image(img0,0,0);
    }     
  else if((mouseX>=800)&(mouseX<=850)&(mouseY>=100)&(mouseY<=150))                                        //当鼠标在矩形区域内单击时
  { 
    clear();
    background(255);
    image(img0,0,0);
    initUI();
  }   
  else if((mouseX>=800)&(mouseX<=850)&(mouseY>=160)&(mouseY<=210))                                        //当鼠标在矩形区域内单击时
  { 
    println("save photo");
    saveFrame("NO."+photonumber+".png");
    photonumber+=1;
  }   
  else if((mouseX>=15)&(mouseX<=65)&(mouseY>=20)&(mouseY<=70))
  {
    println("drawPixelRect");
    drawPixelRect();

  } 
  else if((mouseX>=15)&(mouseX<=65)&(mouseY>=80)&(mouseY<=130))
  {
    println("drawParticle");
    drawParticle();
  } 
  else if((mouseX>=15)&(mouseX<=65)&(mouseY>=140)&(mouseY<=190)){
    println("drawnoisebrush");
    drawnoisebrush(); 
  }
  //else if(mouseX>=15 && mouseX<=65 && mouseY>=200 && mouseY<=250){
  //   println("paint");
  //     clear();
  //background(255);
  //   while(penpaint()==1){}; 

  //}
}

void drawPixelRect(){
  //Ensure nearly-constant area is drawn each time 
  int num_rects = round((5*max_radius*max_radius)/(radius*radius)); 
  clear();
  background(255);
  for(int m=0;m<1000;m++){
    for(int i = 0; i < num_rects; ++i) { 
      float theta = random(TWO_PI); 
      int x = int(random(900)); 
      int y = int(random(600)); 
      color c = img0.get(x,y); 
      fill(c, opacity);
      pushMatrix();
        translate(x,y);
        rotate(theta);
        rect( -radius/2.0, -radius/2.0, radius, radius );
      popMatrix();
    }
  }
}

void initUI(){
   fill(204,102,0);
  rect(800,40,50,50,10);     //绘制矩形  按键换照片
  fill(255);
  text("change",801,60);
  text("photo",805,80);
  
  fill(204,102,0);
  rect(800,100,50,50,10);     //清除屏幕
  fill(255);
  text("clear",805,130);
  
  fill(204,102,0);
  rect(800,160,50,50,10);     //绘制矩形  按键保存照片
  fill(255);
  text("save",807,180);
  text("photo",805,200);
  
  fill(204,102,0);
  rect(15,20,50,50,10);     //绘制矩形  像素处理
  fill(255);
  text("pixel",20,40);
  text("photo",20,60);
  
  fill(204,102,0);
  rect(15,80,50,50,10);     //绘制矩形  线条处理
  fill(255);
  text("liner",20,100);
  text("photo",20,120);
  
  fill(204,102,0);
  rect(15,140,50,50,10);     //绘制矩形  噪声处理
  fill(255);
  text("noise",20,160);
  text("brush",20,180);
  
  //fill(204,102,0);
  //rect(15,200,50,50,10);     //绘制矩形  绘图工具
  //fill(255);
  //text("pen1",23,230);
}

//------------------------------particle begin----------------------------------------
void drawParticle(){
  translate(width/2, height/2);
  noStroke();
  n = 1000;
  s = 20;
  maxR = height/2;
  particles = new ArrayList<Particle>();
  clear();
  background(255);
  
  while(s > 1) {
    if (particles.size() != 0) {
      for (int i = 0; i < particles.size(); i++) {
        Particle p = particles.get(i);
        p.show();
        p.move();

        if (p.isDead()) particles.remove(i);
      }
    } else {
      s -= 3;
      initParticles();
    }
    println("s:",s);
  }
  translate(-width/2, -height/2);
}

void initParticles() {
  for (int i = 0; i < n; i++) {
    particles.add(new Particle(maxR, s));

    Particle p = particles.get(i);
    int x = int(map(p.pos.x, -maxR, maxR, 0,900));
    int y = int(map(p.pos.y, -maxR, maxR, 0,600));

    
    p.c = img[k].get(x, y);
  }
}

class Particle {
  PVector pos;
  PVector vel;
  int maxR;
  int s;
  int life;
  color c;


  Particle(int maxR_, int s_) {
    s = s_;
    maxR = maxR_;
    life = 100;
    init();
  }

  void init() {
    pos = PVector.random2D();
    pos.normalize();
    pos.mult(random(2, maxR));
    vel = new PVector();
  }

  void show() {
    fill(c);
    ellipse(pos.x, pos.y, s, s);
    life -= 1;
  }

  void move() {
    float angle = noise(pos.x * noisePower, pos.y * noisePower) * TAU;
    vel.set(cos(angle), sin(angle));
    vel.mult(0.5);
    pos.add(vel);
  }

  boolean isDead() {
    float d = dist(pos.x, pos.y, 0, 0);
    if (d > maxR || life < 1) return true;
    else return false;
  }
}
//------------------------------particle end----------------------------------------

//------------------------------noisebrushstyle begin--------------------------------------

void drawnoisebrush(){
  float x,y; 
  clear();
  background(255);
  for (int p = 0; p < sampleNum; p += 1) {
    x = random(img0.width);
    y = random(img0.height);
    for (int k = 0; k < singleLineLength; k ++) {

      //point(x, y);
      float x1 = x + width/2 - img0.width/2;
      float y1 = y + height/2 - img0.height/2;
      float x2 = x1 + segmentLength*(noise(x/noiseDivideIndex, y/noiseDivideIndex)-0.5);
      float y2 = y1 + segmentLength*(noise(y/noiseDivideIndex, x/noiseDivideIndex)-0.5);

      // read pixel value
      float lum = brightness(img0.get(int(x), int(y)))/255;//get_grey_from_image(img, int(x), int(y));
      if (lum < lineWeightThrehold) {
        // stroke depends on luminosity
        strokeWeight(map(lum, 0, lineWeightThrehold, 2, 0.1));

        //paint
        //stroke(0, 0, 0, map(lum, 0, 1, 100, 10));

        stroke(0);

        strokeWeight(1);
        line(x1, y1, x2, y2);
        countNumOfLines++;
      }

      x = x2;
      y = y2;
    }
  }

  println("countNumOfLines: "+countNumOfLines); 
}



float get_grey_from_image(PImage im, int x, int y) {
  // red value
  float r = red(im.pixels[x + y*im.width]);
  // green
  float g = green(im.pixels[x + y*im.width]);
  // blue
  float b = blue(im.pixels[x + y*im.width]);

  // use luminosity weighted average
  // https://www.johndcook.com/blog/2009/08/24/algorithms-convert-color-grayscale/
  float luminosity = (0.21*r + 0.72*g + 0.07*b) / 255.0;
  return luminosity;
}

//------------------------------noisebrushstyle end----------------------------------------
