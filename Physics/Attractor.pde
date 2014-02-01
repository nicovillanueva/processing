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
