void setup() {
  size(800, 800); //size of the window
  frameRate(100);//increase this to make the dots go faster
}

void draw(){
  background(43);
  nodes body = new nodes(50,50,20,20);
  body.update(false);
  body.show();
  
}
