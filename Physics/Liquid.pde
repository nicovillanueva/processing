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
