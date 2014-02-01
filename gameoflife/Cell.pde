class Cell{
  private PVector pos;
  private int alive = -1;
  
  public Cell(PVector p){
    this.pos = p;
  }
  
  public boolean giveBirth(){
    if(alive != 1){
      alive = 1;
      return true;
    }
    return false;
  }
  
  public boolean kill() {
    if(alive == 1){
      alive = 0;
      return true;
    }
    return false;
  }
  
  public boolean evict() {
    if(alive != -1) {
      alive = -1;
      return true;
    }
    return false;
  }
  
  public void render(){
    if(this.alive == 1){
      fill(0,180,0);
    } else if(this.alive == 0) {
      fill(180,0,0);
    } else {
      fill(180,180,180);
    }
    rect(this.pos.x, this.pos.y, 10, 10);
  }
}
