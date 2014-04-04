void setup(){
  size(600, 600, P2D);
  H.init(this).background(#242424);
  smooth();
  
  int rwid = 100;
  int rhei = 100;
  
  HRect r = new HRect(rwid, rhei);
  
  new HRotate().target(r).speed(1);
  
  r.rounding(10)
   .fill(#FF6600)
   .stroke(#000000, 150)
   .strokeWeight(6)
   .rotation(0)
   .anchor(-50, -50)
   .loc(width/2,height/2);
   
   
   H.add(r);
   
   //noLoop();
}

void draw() {
  H.drawStage();
}
