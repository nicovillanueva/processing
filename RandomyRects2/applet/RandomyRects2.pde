HCanvas canv;
HColorPool colors;

void setup(){
  size(600, 600);
  H.init(this).background(#242424);
  smooth();

  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);
  
  canv = new HCanvas().autoClear(false).fade(1);
  H.add(canv);
  
  int rectSize = 50;
  float spd = .5;
  
  HRect[] rects = new HRect[8];
  for(int i = 0; i < rects.length; i++){
    rects[i] = new HRect(rectSize);
    
    rects[i].rounding(10)
     .fill(colors.getColor())
     .stroke(#000000, 150)
     .strokeWeight(6)
     .loc(width/2, height/2);
    
    switch (i) {
      case 0:
        new HRotate().target(rects[i]).speed(spd); break;
      case 1:
        new HRotate().target(rects[i]).speed(spd); break;
      case 2:
        new HRotate().target(rects[i]).speed(-spd); break;
      case 3:
        new HRotate().target(rects[i]).speed(-spd); break;
      case 4:
        new HRotate().target(rects[i]).speed(spd); break;
      case 5:
        new HRotate().target(rects[i]).speed(spd); break;
      case 6:
        new HRotate().target(rects[i]).speed(-spd); break;
      case 7:
        new HRotate().target(rects[i]).speed(-spd); break;
    }
  }

  canv.add(rects[0].anchor(rectSize, 0));
  canv.add(rects[1].anchor(0, rectSize));
  
  canv.add(rects[2].anchor(-rectSize, -rectSize));
  canv.add(rects[3].anchor(rectSize*2, rectSize*2));
  
  canv.add(rects[4].anchor(-rectSize*2, rectSize*3));
  canv.add(rects[5].anchor(rectSize*3, -rectSize*2));
  
  canv.add(rects[6].anchor(-rectSize*3, -rectSize*3));
  canv.add(rects[7].anchor(rectSize*4, rectSize*4));  
}

void draw() {
  frame.setTitle(String.valueOf(frameRate));
  H.drawStage();
}
