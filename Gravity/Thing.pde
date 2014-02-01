class Thing {
  
  public PVector position;
  public float mass;
  
  public Thing(PVector pos, float m) {
    this.position = pos;
    this.mass = m;
  }
  
  public render() {
    fill(0);
    ellipse(pos.x, pos.y, m * 10, m * 10);
  }
}
