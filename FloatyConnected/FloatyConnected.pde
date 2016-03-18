int BGCOLOR = 51;
float MINDIST = 50;
boolean SHOWBOX = false;
boolean BLURRY = true;

Coso[] cosos = new Coso[100];
float depth;



void setup() {
  size(600, 600, OPENGL);
  lights();
  smooth();
  fill(255);
  
  depth = -height;
  
  for(int i = 0; i < cosos.length; i++){
    cosos[i] = new Coso(random(12)+3);
  }
}

void draw() {
  frame.setTitle("FC: " + Integer.toString(frameCount) + " FR: " + (int)frameRate);
  
  if(BLURRY){
    fill(51,200);
    rect(0,0,width,height);
  } else {
    background(BGCOLOR);
  }
  
  if(SHOWBOX){
    stroke(200);
    line(0, 0, depth, width, 0, depth);            
    line(0, height, depth, width, height, depth);
    line(0, 0, depth, 0, height, depth);
    line(width, 0, depth, width, height, depth);
    line(0, 0, 0, 0, 0, depth);
    line(0, height, 0, 0, height, depth);
    line(width, 0, 0, width, 0, depth);
    line(width, height, 0, width, height, depth);
  }
  for(Coso c : cosos){
    noStroke();
    //stroke(0);
    //fill(255);
    c.render();
    for(Coso cOther : cosos) {
      if(c != cOther && dist(c.x, c.y, c.z, cOther.x, cOther.y, cOther.z) < MINDIST){
      //if(c != cOther){
        stroke(100);
        line(c.x, c.y, c.z, cOther.x, cOther.y, cOther.z);
      }
    }
  }
}

class Coso {
  public float x, y, z;
  private float dx, dy, dz;
  private float size;
  
  public Coso(float size){
    this.size = size;
    this.dx = random(random(100));
    this.dy = random(random(100));
    //this.dz = random(random(100));
  }
  
  public void render(){
    dx += 0.01;
    dy += 0.01;
    dz += 0.01;
    float newx = noise(dx)*width;
    if(newx > 0 && newx < width)
      this.x = newx;
    float newy = noise(dy) * height;
    if(newy > 0 && newy < height)
      this.y = newy;
    float newz = noise(dz) * -height;
    if(newz > 0 && newz < -height)
      this.z = newz;
    /*
    this.x = noise(dx) * width;
    this.y = noise(dy) * height;
    this.z = noise(dz) * width;
    */
    ellipse(this.x, this.y, this.size, this.size);
    //translate(this.x, this.y, this.z);
    //sphere(this.size);
  }
  
}

void keyPressed(){
  if(key == 's') {
    saveFrame("img.png");
  }
}
