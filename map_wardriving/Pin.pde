class Pin{
  
  private float x, y, z;
  private color c;
  
  public Pin(float x, float y, float z, color c){
    this.x = x;
    this.y = y;
    this.z = z;
    this.c = c;
  }
  
  public void renderPin() {
    fill(this.c);
    println("orig: " + this.x + " " + this.y);
    float tmpx = map(this.x, -180, 180, 0, width);
    float tmpy = map(this.y, 85, -85, 0, height);
    println("mapped: " + tmpx + " " + tmpy);
    ellipse(tmpx, tmpy, 1, 1);
  }
}
