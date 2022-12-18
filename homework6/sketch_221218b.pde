int fishNum = 1000;
Fish[] fish = new Fish[fishNum];
int bigFishNum=2;
Fish2[] bigFish=new Fish2[bigFishNum];
boolean mouseDown = false;
 
void setup(){
  size(1280, 900);
  background(255);
  fill(0);
  //smooth();
 
  for(int i=0; i<fishNum; i++){
    fish[i] = new Fish(random(width), random(height));
  }
  
  //for(int i=0; i<bigFishNum; i++){
    //bigFish[i] = new Fish2(random(width), random(height));
  //}
  bigFish[0] = new Fish2(300,500);
  bigFish[1] = new Fish2(800,400);
}
 
void mousePressed(){
  mouseDown = true;
}

void mouseReleased(){
  mouseDown = false;
}

void draw(){
  background(255);
 
  for(int i=0; i<fishNum; i++){
    fish[i].update();
  }
  for(int i=0; i<bigFishNum; i++){
    bigFish[i].update();
  }
  for(int i = 0; i<fishNum-1; i++){
    for(int c = i+1; c<fishNum; c++){
      float d = dist(fish[i].x, fish[i].y, fish[c].x, fish[c].y)+1;
 
      if( d <= 40 ){
        fish[i].xv += .004*(fish[i].x - fish[c].x);
        fish[i].yv += .004*(fish[i].y - fish[c].y);
 
        fish[c].xv += .004*(fish[c].x - fish[i].x);
        fish[c].yv += .004*(fish[c].y - fish[i].y);
      }
     //else if( d>80 && d <=100){
     //   fish[i].xv -= .000005*(fish[i].x - fish[c].x);
     //   fish[i].yv -= .000005*(fish[i].y - fish[c].y);
 
     //   fish[c].xv -= .000005*(fish[c].x - fish[i].x);
     //   fish[c].yv -= .000005*(fish[c].y - fish[i].y);
 
     //   fish[i].xv += ((fish[c].xv+fish[i].xv)/2-fish[i].xv)*.01;
     //   fish[i].yv += ((fish[c].yv+fish[i].yv)/2-fish[i].yv)*.01;
     // }
      

       float d2 = dist(bigFish[0].x,bigFish[0].y, fish[i].x, fish[i].y);
         if(d2<300){
         fish[i].xv -= .1*(bigFish[0].x-fish[i].x)/d2;
         fish[i].yv -= .10*(bigFish[0].y-fish[i].y)/d2;
         }
       d2 = dist(bigFish[1].x,bigFish[1].y, fish[i].x, fish[i].y);
         if(d2<300){
         fish[i].xv -= .10*(bigFish[1].x-fish[i].x)/d2;
         fish[i].yv -= .10*(bigFish[1].y-fish[i].y)/d2;
         }
    }
  }
  
    float d = dist(bigFish[0].x, bigFish[0].y, bigFish[1].x, bigFish[1].y)+1;
 
      if( d <= 80 ){
        bigFish[0].xv += .0001*(bigFish[0].x - bigFish[1].x);
        bigFish[0].yv += .0001*(bigFish[0].y - bigFish[1].y);
 
        bigFish[1].xv += .0001*(bigFish[1].x - bigFish[0].x);
        bigFish[1].yv += .0001*(bigFish[1].y - bigFish[0].y);
      }
      else if( d>00 && d <=500){
        bigFish[0].xv -= .000000125*(bigFish[0].x - bigFish[1].x);
        bigFish[0].yv -= .000000125*(bigFish[0].y - bigFish[1].y);
 
        bigFish[1].xv -= .000000125*(bigFish[1].x - bigFish[0].x);
        bigFish[1].yv -= .000000125*(bigFish[1].y - bigFish[0].y);
 
        bigFish[0].xv += ((bigFish[1].xv+bigFish[0].xv)/2-bigFish[0].xv)*.0005;
        bigFish[0].yv += ((bigFish[1].yv+bigFish[0].yv)/2-bigFish[0].yv)*.0005;
      }

}
 
 
class Fish {
 
  float x,y;
  float xv = random(-1,1), yv = random(-1,1);
  float tailStep = 0, tailSpeed = random(2,3);
  color c = color(random(255), random(255), random(255) );
 
  float s = random(.05,.2);
  
  //Bezier points///////
  float sx = -90, sy = 0;
 
  float ax = -40, ay = 0;
  float bx = 5, by = 40;
 
  float cx = -40, cy = 0;
  float dx = 5, dy = -40;
 
  float ex = 10, ey = 0;
 
  float animOff = random(TWO_PI);
  ////////////////////////
 
  Fish(float x, float y){
    this.x = x;
    this.y = y;
  }
 
  void update(){
    this.tailStep += this.tailSpeed;
    
    this.xv += (  noise(  this.x*.01 + PI,this.y*.01, millis()*.00002  )*2-1  )*.3;
    this.yv += (  noise(  this.x*.01 - PI,this.y*.01, millis()*.00002  )*2-1  )*.3;

    this.xv = constrain(this.xv, -2,2);
    this.yv = constrain(this.yv, -2,2);
 
    this.x += this.xv;
    this.y += this.yv;
 
    drawFish();
 
    if(this.x<-10){
      this.x = width+10;
    }
    else if(this.x>width+10){
      this.x = -10;
    }
 
    if(this.y<-10){
      this.y = height+10;
    }
    else if(this.y>height+10){
      this.y = -10;
    }
  }
 
  void drawFish(){
    sy = 60*sin( this.tailStep*.1 + this.animOff);
    pushMatrix();
    fill(0);
    translate(this.x, this.y);
    scale(this.s,this.s);
    rotate( atan2(this.yv, this.xv) );
 
    bezier( this.sx,this.sy, this.ax,this.ay, this.bx,this.by, this.ex,this.ey );
    bezier( this.sx,this.sy, this.cx,this.cy, this.dx,this.dy, this.ex,this.ey );
    //strokeWeight(3);
    line( this.sx,this.sy, this.ex,this.ey);
 
    //line(0,0,this.xv*3,this.yv*3);//,3,3);
    popMatrix();
  }
}
 
class Fish2 {
 
  float x,y;
  float xv = random(-0.5,0.5), yv = random(-0.5,0.5);

  float s = random(.7,.8);

  ////////////////////////
 
  Fish2(float x, float y){
    this.x = x;
    this.y = y;
  }
 
  void update(){
    this.xv += (  noise(  this.x*.01 + PI,this.y*.01, millis()*.00002  )*2-1  )*.0075;
    this.yv += (  noise(  this.x*.01 - PI,this.y*.01, millis()*.00002  )*2-1  )*.0075;

    this.xv = constrain(this.xv, -0.1,0.1);
    this.yv = constrain(this.yv, -0.1,0.1);
 
    this.x += this.xv;
    this.y += this.yv;
 
    drawFish();
 
    if(this.x<-5){
      this.x = width+5;
    }
    else if(this.x>width+5){
      this.x = -5;
    }
 
    if(this.y<-5){
      this.y = height+5;
    }
    else if(this.y>height+5){
      this.y = -5;
    }
  }
 
  void drawFish(){
    pushMatrix();
    fill(255,0,0);
    translate(this.x, this.y);
    scale(this.s,this.s);
 
    strokeWeight(3);
    ellipse(this.x, this.y,100,100);
    popMatrix();
  }
}
