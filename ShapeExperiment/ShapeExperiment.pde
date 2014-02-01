import processing.video.*;

Movie mov;
PShape hex, iHex;

void setup() {
  size(600, 600, P2D);
  background(51);
  
  // ---------
  
  mov = new Movie(this, "watercrop.avi");
  mov.loop();
  
  // ---------
  
  hex = createShape();
  iHex = createShape();
  
  hex.beginShape();
  hex.noFill();
  hex.strokeWeight(1);
  hex.stroke(255);
  hex.vertex(width/2, height/4);
  hex.vertex(width/4, height/4 * 3);
  hex.vertex(width/4 * 3, height/4*3);
  hex.endShape(CLOSE);
  
  iHex.beginShape();
  iHex.stroke(255);
  iHex.noFill();
  for(int i = 0; i < hex.getVertexCount(); i++){
    PVector v = hex.getVertex(i);
    v.y *= -1;
    iHex.vertex(v.x, v.y + height);
  }
  iHex.endShape(CLOSE);
  
  
}

void draw(){
  frame.setTitle(String.valueOf(frameRate));
  if(mov.available()){
    mov.read(); 
  }
  
  mov.loadPixels();
  for(int h = 0; h < height; h++){
    for(int w = 0; w < width; w++){
     int pxl = mov.pixels[(width * h) + w];
     float r = blue(pxl);
     float g = red(pxl);
     float b = green(pxl);
     
     mov.pixels[(width * h) + w] = color(r,g,b);
    }
  }
  mov.updatePixels();
  image(mov, 0, 0);
  shape(hex);
  shape(iHex);
}
/*
void movieEvent(Movie m){
  m.read();
}
*/
