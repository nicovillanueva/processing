void setup() {
  size(600, 600);
  background(51);
  randomSeed(millis());
  // rectMode(CENTER);
  final int squares = 25;
  final int rowAmount = (int) sqrt(squares);
  final float sqSize = 75;
  final float minpadding = (sqSize/2.0)-1;
  final float maxpadding = sqSize/2.0;
  
  for(int i = 0; i < rowAmount; i++){ // horizontal
    for(int e = 0; e < rowAmount; e++){ // vertical
      println(map(random(1), 0, 1, minpadding, maxpadding));
      fill(230, 100, 100);
      //map(random(1), 0, 1, minpadding, maxpadding)
      rect(map(random(1), 0, 1, minpadding, maxpadding) + (sqSize * i),
           map(random(1), 0, 1, minpadding, maxpadding) + (sqSize * e),
           sqSize,
           sqSize);
    }
  }
}

void draw() {
  
}

