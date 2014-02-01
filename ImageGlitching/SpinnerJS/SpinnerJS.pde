/* @pjs preload="outrun_2.jpg" */
PImage src, dst;
float r, g, b, rotx, roty;
color c;

int range = 15;

void setup() {
  size(500, 308); // extra so that the content div gives proper way for the canvas
  imageMode(CENTER);
  
  range = 15;
  size(440 + range * 2, 308 + range * 2); // size is redefined taking into account the range
  src = loadImage("outrun_2", "jpg");
  dst = new PImage(src.width, src.height);
  
  r = g = b = rotx = roty = 0;
}

void draw() {
  background(0);
  
  loadPixels();
  
  for(int h = 0; h < src.height; h++){
    for(int w = 0; w < src.width; w++){
      
      r = red(src.get(w+(int)(cos(rotx) * range), h + (int)(sin(roty) * range)));
      g = green(src.get(w,h));
      b = blue(src.get(w-(int)(cos(rotx) * range), h - (int)(sin(roty) * range)));
      c = color(r,g,b);
      
      dst.set(w, h, c);
    }
  }
  
  rotx += 0.5;
  roty += 0.5;
  updatePixels();
  
  image(dst, width/2, height/2);

}
