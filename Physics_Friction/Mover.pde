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
