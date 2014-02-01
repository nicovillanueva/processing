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
