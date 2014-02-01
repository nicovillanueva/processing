Walker[] walkers = new Walker[10]; 

Walker w;

void setup() {
  size(600, 200);
  background(255);
  frameRate(30);
  
  for(int i = 0; i < 10; i++){
    walkers[i] = new Walker(i, new PVector(width / 10 * i, 10));
  }
}

void draw() {
  fill(255,120);
  rect(0, 0, width, height);
  
  for(int i = 0; i < walkers.length; i++){
    walkers[i].checkEdges();
    /*
    walkers[i].applyForce(this.wind);
    walkers[i].applyForce(this.gravity);
    walkers[i].move();
    */
    walkers[i].stepPerlin();
    walkers[i].render();
  }
}

void keyReleased() {
  if(key == 'd') {
    this.w.setDebug();
  }
}
