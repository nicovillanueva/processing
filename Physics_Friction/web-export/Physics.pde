Mover[] movers = new Mover[10];

PVector gravity;
PVector wind;
PVector water;
FrictionPocket sandpaper;

void setup() {
  size(600, 200);
  background(255);
  frameRate(30);
  
  this.sandpaper = new FrictionPocket(0.5, 1, width/2, height/2, 50, 50);
  
  for(int i = 0; i < movers.length; i++){  
    movers[i] = new Mover(new PVector(random(0, width), 10), random(1, 10));
    //movers[i] = new Mover(new PVector(random(0, width), 10), i);
    //movers[i] = new Mover(new PVector(random(0, width), 10), 10);
  }
}

void draw() {
  
  fill(253, 40);
  rect(0, 0, width, height);
  
  for(int i = 0; i < movers.length; i++){
    movers[i].checkEdges();
    
    this.gravity = new PVector(0, 0.1 * movers[i].getMass()); // gravity scaled by mass
    this.wind = new PVector(0.01, 0);
    
    movers[i].applyForce(this.wind);
    movers[i].applyForce(this.gravity);
    
    if(this.sandpaper.checkIfInside(movers[i].getPosition())){
      movers[i].applyForce(this.sandpaper.getFriction(movers[i].getVelocity()));
    }
    
    movers[i].move();
    this.sandpaper.render();
    movers[i].render();
  }
  
  console.log(frameRate);
}

/*
private PVector getFriction(PVector vel) {
  float c = 0.01;
  float normal = 1;
  float frictionMagnitude = c * normal;
  PVector friction = vel;
  // Friction = Velocity inverted, multiplied by drag coefficient.
  // (simplified formula)
  friction.mult(-1);
  friction.normalize();
  friction.mult(frictionMagnitude);
  return friction;
} */
class FrictionPocket {
  
  private float coefficient;
  private float normal;
  private float frictMag;
  private float x, y, w, h;
  
  public FrictionPocket(float c, float n, float x, float y, float w, float h) {
    this.coefficient = c;
    this.normal = n;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.frictMag = this.coefficient * this.normal;
  }
  
  public PVector getFriction(PVector vel) {
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
    return this.velocity;
  }
  
  public PVector getPosition() {
    return this.position;
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

