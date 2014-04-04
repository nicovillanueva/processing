HColorPool colors;
float nX, nY;

void setup() {
  size(600, 600, P2D);
  H.init(this).background(#202020);
  smooth();
  //stroke(5);
  noStroke();
  rectMode(CENTER);
  nX = random(0, 10000);
  nY = random(0, 10000);
  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);
}

void draw() {
  frame.setTitle(String.valueOf((int)frameRate));
  fill(#202020, 5);
  rect(width/2, height/2, width, height);
  nX += 0.01;
  nY += 0.01;
  
  if(frameCount % 2 == 0){
    float rX, rY, rW, rH;
    rX = map(noise(nX), 0.0, 1.0, 0, width);
    rY = map(noise(nY), 0.0, 1.0, 0, height);
    rW = random(20, 80); 
    rH = random(20, 80);
    fill(colors.getColor());
    rect(rX, rY, rW, rH);
  }
}

void keyPressed() {
  if(key == 'c'){
    fill(#202020);
    rect(width/2, height/2, width, height);
  }
  else if(key == 'C'){
    fill(#FFFFFF);
    rect(width/2, height/2, width, height);
  }
}
