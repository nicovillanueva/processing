import ddf.minim.*;

Minim minim;
AudioInput in;

void setup() {
  size(600, 600, P2D);
  rectMode(CENTER);
  background(51);
  //noStroke();
  
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  background(51);
  
  fill(255);
  
  float barSize = map(in.mix.get(0), -1, 1, 0, height);
  rect(width/2, height/2, 50, barSize);
  println(in.mix.get(0) + " > " + barSize);
}
