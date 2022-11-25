void setup(){
 size(800,200); 
}
int x0=0,y0=0,x1,y1;
int y;
void draw(){
 saveFrame();
 for(int x=0;x<width;x+=20){
  y=int(random(200));
  line(x0,y0,x,y);
  x0=x;
  y0=y;
 }
 x0=0;
 y0=0;
 fill(255,255,255,8);
 rect(0,0,width,height);
}
