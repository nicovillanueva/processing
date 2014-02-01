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

