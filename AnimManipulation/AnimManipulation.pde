PShape hex, square;
Animation anim;

void setup() {
  size(500, 500, P2D);
  frameRate(24);
  
  // ---------
  
  anim = new Animation("soothing_", 10);
  
  // ---------
  
  background(51);
  
  hex = createShape();
  square = createShape();
  
  square.beginShape();
  square.noFill();
  square.strokeWeight(2);
  square.stroke(255);
  square.vertex(10, 10);
  square.vertex(10, 30);
  square.vertex(30, 30);
  square.vertex(30, 10);
  square.vertex(10, 10);
  square.endShape();
  
  
  hex.beginShape();
  hex.noFill();
  hex.strokeWeight(2);
  hex.stroke(255);
  
  translate(width/2, height/2);
  for(int i = 0; i < 7; i++){
    hex.vertex(0, -70); // FUCK
    rotate(radians(60));
    text(String.valueOf(i), 0, -70, 0);
  }
  
  hex.endShape();
  //popMatrix();
  
  //shape(hex, width/2, height/2);
}

void draw(){
  // frame.setTitle(String.valueOf(frameRate));
  // anim.display(0,0);
  hex.setFill(color(#FFFFFF));
  hex.setStrokeWeight(5);
  hex.setStroke(color(#FFFFFF));
  shape(hex, 0,0);
  
  shape(square, width/2, height/2);
}



class Animation {
  PImage[] imgs;
  int imgCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imgCount = count;
    imgs = new PImage[imgCount];
    
    for(int i = 0; i < imgCount; i++){
      String filename = imagePrefix + nf(i,2) + ".png";
      imgs[i] = loadImage(filename);
    }
  }
  
  void display(float x, float y){
    frame = (frame+1) % imgCount;
  /*  PImage img = imgs[frame];
    float r = red(img.pixels[width*400+10]);
    r += 200.0f;
    img.pixels[width*400+10] = color(r, blue(img.pixels[width*400+10]), green(img.pixels[width*400+10]));
    */
    image(imgs[frame], x, y);
  }
  
  int getWidth() {
    return imgs[0].width;
  }
}
