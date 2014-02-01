Cell[][] cells = new Cell[60][60];

void setup() {
  size(600,600);
  background(0);
  
  for(int w = 0; w < 60; w++){
    for(int h = 0; h < 60; h++){
      float cx = w * (600 / 60);
      float cy = h * (600 / 60);
      cells[w][h] = new Cell(new PVector(cx,cy));
    }
  } 
}

void draw() {
  
  // Draw the cells
  for(int i = 0; i < 60; i++){
    for(int e = 0; e < 60; e++){
      cells[i][e].render();
    }
  }
}

void keyReleased(){
  if(key == 's'){
    spawnLife();
  }
  else if (key == 'k'){
    genocide();
  }
}

void spawnLife() {
  int newborns = 0;
  for(int w = 0; w < 60; w++){
    for(int h = 0; h < 60; h++){
      float fate = Math.random();
      if(fate > 0.9){
        if(cells[w][h].giveBirth()){
          newborns += 1;
        }
      }
    }
  } 
  println("Gave birth to " + newborns + " new cells");
}

void genocide() {
  int casualties = 0;
  for(int w = 0; w < 60; w++){
    for(int h = 0; h < 60; h++){
      float fate = Math.random();
      if(fate > 0.9){
        if(cells[w][h].kill()){
          casualties += 1;
        }
      }
    }
  }
  println("Killed off: " + casualties + " cells");
}
