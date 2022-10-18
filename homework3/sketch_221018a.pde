int x,y,h,g;
int k;
void setup(){
  size(600,500);
  frameRate(100);
  background(255);
}
int cl=0;
void draw(){
  k=1;
  stroke(0);
  strokeWeight(5);

   saveFrame();
   x=int(random(600)); 
   y=int(random(500));
   h=int(random(150));
   g=int(random(150));
   if(x+h<=150*k || x>600-150*k || y+g<=150*k || y>500-150*k){
     cl=int(random(100));
     if(cl<=20){//RBG(255,50,50)
       fill(230,80,80);
     }else if(cl<=40){//RGB(50,255,50)
       fill(80,230,80);
     }else if(cl<=60){//RGB(50,50,255)
       fill(80,80,230);
     }else{
       fill(255,255,255);
     }
     
     rect(x,y,h,g);
   }
 
}
