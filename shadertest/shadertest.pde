PShader shade;

void setup(){
  size(720,720, P2D);
  shade = loadShader("lines.glsl");
  
}

void draw() {
  shade.set("time", (float) frameCount);
  shade.set("mouse", new PVector(mouseX, mouseY));
  shade.set("resolution", new PVector(width, height));
  shader(shade);
  rect(0,0,width, height);
}

void keyPressed()
{
  setup();
}
