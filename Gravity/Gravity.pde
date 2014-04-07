float gravConstant;

Thing t1;
Thing t2;

void setup() {
  size(100, 100);
  t1 = new Thing(new PVector(10, 50), 2);
  t2 = new Thing(new PVector(90, 50), 5);
}

void draw() {
  // versor
  PVector dir = PVector.sub(t1.position, t2.position);
  float distance = dir.magnitude(); // distance
  dir.normalize();
  
  
  
  // gravity
  float force = (gravConstant * t1.mass * t2.mass) / (Math.sq(distance));
  dir.mult(force);
}
