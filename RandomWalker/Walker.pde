class Walker{
  
  private float size;
  private PVector position;
  private PVector velocity;
  private PVector accel;
  private float topSpeed;
  private float mass;
  
  private float tx, ty;
  private Random generator;
  
  private boolean debug;
  
  // ----------------------------
  
  public Walker(float mass, PVector pos){
    this.size = mass;
    this.position = new PVector(pos.x, pos.y);
    this.velocity = new PVector(0.0, 0.0);
    this.accel = new PVector(0.0, 0.0);
    this.mass = mass;
    this.topSpeed = 2.0;
    
    this.tx = random(0, 10000);
    this.ty = random(0, 10000);
    generator = new Random();
  }
  
  // ----------------------------
  // MOVEMENT SETTINGS
  
  // Modify accel using perlin
  public void updateAccelPerlin() {
    tx += 0.001;
    ty += 0.001;
    float noisex = map(noise(tx), 0.0, 1.0, -0.3, 0.3);
    float noisey = map(noise(ty), 0.0, 1.0, -0.3, 0.3);
    accel = new PVector(noisex, noisey);
    velocity.add(accel); // vectors addition
    velocity.limit(topSpeed); // don't go over magnitude 10
    position.add(velocity); // true moving
  }
 
 // Step using perlin noise
  public void stepPerlin() {
    tx += 0.01;
    ty += 0.01;
    float noisex = map(noise(tx), 0.0, 1.0, -(width * 0.5), width * 1.5);
    float noisey = map(noise(ty), 0.0, 1.0, -(height * 0.5), height * 1.5);
    this.position.x = noisex;
    this.position.y = noisey;
  }
  
  // Step with Gaussian distribution
  public void stepGaussian() {
    float stdDeviation = 3; // Scatter
    float mean = 2;
    float stpx = stdDeviation * generator.nextGaussian() + mean;
    float stpy = stdDeviation * generator.nextGaussian() + mean;
    this.position.x += stpx - mean;
    this.position.y += stpy - mean; 
  }
  
  public void accelTowardsMouse() {
    PVector mousepos = new PVector(mouseX, mouseY);
    PVector heading = PVector.sub(mousepos, this.position);
    heading.normalize();
    heading.mult(0.2);
    
    this.applyForce(heading);
        
    if(debug) {
      stroke(0);
      line(mousepos.x, mousepos.y, this.position.x, this.position.y, 1);
    }
  }
  
  // ----------------------------
  
  public void applyForce(PVector f){
    PVector tmpForce = f.get(); // Avoid getting 'f' overwritten.
    tmpForce.div(this.mass);
    this.accel.add(tmpForce);
  }
  
  // ----------------------------

  public void setDebug() {
    if(this.debug){
      this.debug = false;
    } else {
      this.debug = true;
    }
  }
  
  // ----------------------------
  
  public void move() {
    this.velocity.add(this.accel);
    this.position.add(this.velocity);
    this.accel.mult(0);
  }
  
  public void render() {
    if(debug) {
      fill(0);
      text("FPS: " + (int)frameRate, 1, 10);
    }
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
