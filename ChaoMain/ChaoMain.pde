void setup() {
  size(800, 800); //size of the window
  frameRate(100);//increase this to make the dots go faster
}

void draw(){
  PVector gravity = new PVector(0,-9.8);
  background(43);
  nodes body = new nodes(20,20,20);
  body.show();
}
