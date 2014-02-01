PImage map;
String[] lines;
ArrayList<Pin> pins = new ArrayList();

void setup() {
  map = loadImage("resized_map.jpg");
  size(map.width, map.height);
  colorMode(RGB);
  
  lines = loadStrings("WigleDump.csv");
  for(int i = 2; i < lines.length; i++){ // i = 2 because the first 2 lines are Wigle's shit
    String[] apData = splitTokens(lines[i], ",");
    println("Lat: " + apData[6] + " Long: " + apData[7] + " Alt: " + apData[8]);
    pins.add(new Pin(Float.valueOf(apData[6]), Float.valueOf(apData[7]), Float.valueOf(apData[8]), (#FF0000)));
  }
  image(map, 0, 0);
  
  noStroke();
  noLoop();
}

void draw() {
  //translate(width/2, height/2);
  (new Pin(0,0,0,#FF0000)).renderPin();
  for(Pin p : pins){
    p.renderPin();
  }
}
