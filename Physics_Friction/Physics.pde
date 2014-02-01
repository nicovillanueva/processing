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
