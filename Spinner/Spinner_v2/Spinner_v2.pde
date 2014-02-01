String imageToFuck = "outrun_2.jpg";
PImage img, img2;
int range;
float r, g, b, rotx, roty;
color c;

void setup() {
  img = loadImage(imageToFuck);
  img2 = new PImage(img.width, img.height);
  
  range = 15;
  rotx = roty = 0;
  
  size(img.width + 20, img.height + 20);
  imageMode(CENTER);

}

void draw() {
  background(0);
//  frame.setTitle("FR: " + frameRate);
  
  loadPixels();
  
  for(int h = 0; h < img.height; h++){
    for(int w = 0; w < img.width; w++){
      
      r = red(img.get(w+(int)(cos(rotx) * range), h + (int)(sin(roty) * range)));
      g = green(img.get(w,h));
      b = blue(img.get(w-(int)(cos(rotx) * range), h - (int)(sin(roty) * range)));
      c = color(r,g,b);
      
      img2.set(w, h, c);
    }
  }
  
  rotx += 0.5;
  roty += 0.5;
  
  updatePixels();
  
  tint(255,255);
  image(img2, width/2, height/2);
  
}

