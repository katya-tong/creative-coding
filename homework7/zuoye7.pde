//2D fractal tree
import controlP5.*;
import peasy.*;
import nervoussystem.obj.*;

int originalHeight = 150;
int originalWidth = 20;
int branchNumber = 2;
float bifurcationRadian = PI*1/3;
float changeRate = 0.5;

PeasyCam cam;
ControlP5 bar;

void setup(){
  size(1000, 900, P2D);
  //stroke(0);
  cam = new PeasyCam(this, 2000);
  UI();
}

void draw(){
  background(220);
  //calling drawTree subroutine
  drawTree(width/2,height,0,originalHeight, originalWidth,200);
  UIShow();
}

//making a subroutine to draw 2D Tree
//parameter x stands for the x position of the starting point of the branch
//parameter y stands for the y position fo the starting point of the branch
//parameter branch used for calculating the length and direction(angle) of the branch
void drawTree(float x, float y, float ang, float len,float wid,float col){
  //setting the condition to activate the command only if the branch size is bigger than 10
 if(len<5) return;
  
  float y1=y-len*cos(ang);
  float x1=x+len*sin(ang);
  stroke(60,180-col,60);
  strokeWeight(wid);
  line(x,y,x1,y1);
  println(x1," ",y1," ",x," ",y," ",ang);

  float angpiece=bifurcationRadian/(branchNumber-1);
  float ang0=-bifurcationRadian/2.0;
  for (int i=0;i<branchNumber;i++){
   float ang1=ang+ang0+i*angpiece;
   
   drawTree(x1,y1,ang1,len*changeRate,wid*changeRate,col*changeRate);
  }


}
