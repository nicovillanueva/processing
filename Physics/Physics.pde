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

