//import processing.video.*;

PShape hex;
Animation anim;

void setup() {
  size(500, 500, P2D);
  frameRate(24);
  
  // ---------
  
  anim = new Animation("soothing_", 10);
  
  // ---------
  
  hex = createShape();
  
  fill(255);
  background(51);
 // pushMatrix();
  hex.beginShape();
  hex.strokeWeight(2);
  hex.stroke(255);
  
  translate(width/2, height/2);
  for(int i = 0; i < 6; i++){
    hex.vertex(0, -50); // TESELLATION ERROR
    rotate(radians(60));
    ellipse(0, -50, 2,2);
  }
  
  hex.endShape(CLOSE);
  //popMatrix();
}

void draw(){
  frame.setTitle(String.valueOf(frameRate));
  
  shape(hex);
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
