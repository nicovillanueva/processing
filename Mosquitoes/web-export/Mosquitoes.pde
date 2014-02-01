Mosquito[] mosquitoes = new Mosquito[10]; 

void setup() {
  size(600, 200);
  background(255);
  frameRate(30);
  
  for(int i = 0; i < 10; i++){
    mosquitoes[i] = new Mosquito(i, new PVector(width / 10 * i, 10));
  }
}

void draw() {
  fill(255,120);
  rect(0, 0, width, height);
  
  for(int i = 0; i < mosquitoes.length; i++){
    mosquitoes[i].checkEdges();

    mosquitoes[i].stepPerlin();
    mosquitoes[i].render();
  }
}

class Mosquito {
  
  private float size;
  private PVector position;
  private float tx, ty;
  private float noisex, noisey;
  
  // ----------------------------
  
  public Mosquito(float s, PVector pos){
    this.size = s;
    this.position = new PVector(pos.x, pos.y);
    this.tx = random(0, 10000);
    this.ty = random(0, 10000);
  }
  
  // ----------------------------

 // Step using perlin noise
  public void stepPerlin() {
    this.tx += 0.01;
    this.ty += 0.01;
    this.noisex = map(noise(tx), 0.0, 1.0, -(width * 0.5), width * 1.5);
    this.noisey = map(noise(ty), 0.0, 1.0, -(height * 0.5), height * 1.5);
    this.position.x = noisex;
    this.position.y = noisey;
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

