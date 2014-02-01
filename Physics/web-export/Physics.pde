Mover[] movers = new Mover[10];

PVector gravity;
PVector wind;
Liquid water;
Friction sandpaper;
Attractor attractor;

void setup() {
  size(600, 200);
  background(255);
  frameRate(30);
  
  // Forces
  sandpaper = new Friction(0.9, 1, width/3 * 1, height/2-50, 50, 50);
  water = new Liquid(0.1, 0, height/3 * 2, width, height/3);
  attractor = new Attractor(-1000, 400, 100);
  
  // Movers
  resetPositions(movers);
}

void draw() {
  fill(253, 40);
  rect(0, 0, width, height);
  
  // Affect all movers
  for(int i = 0; i < movers.length; i++){
    movers[i].checkEdges();
    
    // Simple forces
    this.gravity = new PVector(0, 0.1 * movers[i].getMass()); // gravity scaled by mass
    this.wind = new PVector(0.08, 0);
    
    movers[i].applyForce(this.wind);
    movers[i].applyForce(this.gravity);
    
    movers[i].applyForce(attractor.getForce(movers[i].getMass(), movers[i].getPosition()));
    
    // Force areas
    if(sandpaper.checkIfInside(movers[i].getPosition())){
      movers[i].applyForce(sandpaper.getForce(movers[i].getVelocity()));
    }
    
    if(water.checkIfInside(movers[i].getPosition())) {
      movers[i].applyForce(water.getForce(movers[i].getVelocity()));
    }
    
    // Actual movers' movement
    movers[i].move();
    
    // Rendering
    sandpaper.render();
    water.render();
    attractor.render();
    movers[i].render();
  }
  
  //console.log(frameRate);
}

void keyReleased() {
  if(key == 'r') {
    this.resetPositions(movers);
  }
}

public void resetPositions(Mover[] m) {
  for(int i = 0; i < m.length; i++){  
    m[i] = new Mover(new PVector(random(0, width), 10), random(1, 10));
  }
}

class Attractor {
  
  private float mass;
  private float x, y;
  private float G;
  
  public Attractor(float m, float x, float y) {
    this.mass = m;
    this.x = x;
    this.y = y;
    this.G = 1;
  }
  
  public PVector getForce(float mass, PVector pos) {
    // Ignoring gravitational constant
    PVector force = PVector.sub(pos, new PVector(this.x, this.y));
    float dist = force.mag();
    
    dist = constrain(dist, 5.0, 50.0);
    
    force.normalize();
    console.log("masses: attractor: " + this.mass + " mover: " + mass);
    PVector strength = (G * this.mass * mass) / (dist * dist);
    force.mult(strength);
    return force;
  }
  
  public void render() {
    fill(90, 10);
    ellipse(this.x, this.y, 10, 10); 
  } 
  
  
}
class Friction {
  
  private float coefficient;
  private float normal;
  private float frictMag;
  private float x, y, w, h;
  
  public Friction(float c, float n, float x, float y, float w, float h) {
    this.coefficient = c;
    this.normal = n;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.frictMag = this.coefficient * this.normal;
  }
  
  public PVector getForce(PVector vel) {
    PVector friction = vel.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(this.frictMag);
    return friction;
  }
  
  public boolean checkIfInside(PVector pos) {
    float hhl = this.x + this.w;
    float hll = this.x;
    float vhl = this.y + this.h;
    float vll = this.y;
    if( (pos.x > hll && pos.x < hhl) && (pos.y > vll && pos.y < vhl) ){
      return true;
    }
    return false;
  }
  
  public void render() {
    fill(70, 10);
    rect(this.x, this.y, this.w, this.h);
  }
  
}
class Liquid {
  private float x, y, w, h;
  private float c, d, a;
  
  public Liquid(float c, float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.a = 1; // front area/aerodynamics
    this.d = 1; // fluid density
    this.c = c;
  }
  
  private PVector getForce(PVector vel) {
    //PVector v = vel.get();
    float speed = vel.get().mag();
    float dragMagnitude = this.c * sq(speed) * this.a * this.d;
    
    PVector invVel = vel.get();
    
    invVel.mult(-0.5);
    invVel.normalize();
    invVel.mult(dragMagnitude);
    
     
    
    return invVel;
  }
  
  public boolean checkIfInside(PVector pos) {
    float hhl = this.x + this.w;
    float hll = this.x;
    float vhl = this.y + this.h;
    float vll = this.y;
    if( (pos.x > hll && pos.x < hhl) && (pos.y > vll && pos.y < vhl) ){
      return true;
    }
    return false;
  }
  
  public void render() {
    fill(0, 0, 100, 10);
    rect(this.x, this.y, this.w, this.h);
  }
}
class Mover {
  
  private float size;
  
  private PVector position;
  private PVector accel;
  private PVector velocity;
  private float mass;
  
  public Mover(PVector pos, float m) {
    this.accel = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
    
    this.position = pos;
    this.mass = m;
    this.size = m * 2;
  }
  
  public float getMass() {
    return this.mass;
  }
  
  public PVector getVelocity() {
    return this.velocity.get();
  }
  
  public PVector getPosition() {
    return this.position.get();
  }
  
  public void applyForce(PVector f){
    PVector tmpForce = f.get(); // Avoid getting 'f' overwritten.
    tmpForce.div(this.mass);
    this.accel.add(tmpForce);
  }
  
  public void move() {
    this.velocity.add(this.accel);
    this.position.add(this.velocity);
    this.accel.mult(0);
  }
  
  public void render() {
    fill(255, 200);
    ellipse(this.position.x, this.position.y, this.size, this.size);
  }
  
  public void checkEdges() {
    if(this.position.x < this.size || this.position.x > width - this.size / 2){
      this.velocity.x *= -1;
      if(this.position.x < this.size) { this.position.x = this.size; } else { this.position.x = width - this.size / 2; }
    }
    if(this.position.y < this.size || this.position.y > height - this.size / 2){
      this.velocity.y *= -1;
      if(this.position.y < this.size) { this.position.y = this.size; } else { this.position.y = height - this.size / 2; }
    }
  }
}

