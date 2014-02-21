PShape hex;
Animation anim;

void setup() {
  size(500, 500, P2D);
  frameRate(24);
  background(51);
  
  // ---------
  
  anim = new Animation("soothing_", 10);
  
  // ---------
  
  int sides = 6;
  float radius = width/4;
  
  // ---------
  
  hex = createShape();

  hex.translate(width/2, height/2); // bring global 0,0 to center
  
  hex.beginShape();
  hex.noFill();
  hex.strokeWeight(2);
  hex.stroke(255);
  for(int i = 0; i < sides; i++){
    float x = cos(TWO_PI / sides*i) * radius;
    float y = sin(TWO_PI / sides*i) * radius;
    hex.vertex(x, y);
  }
  hex.endShape(CLOSE);
}

  // ---------

void draw(){
  frame.setTitle(String.valueOf(frameRate));
  anim.display(0,0);
  filter(INVERT);
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
    image(imgs[frame], x, y);
  }
  
  int getWidth() {
    return imgs[0].width;
  }
}
