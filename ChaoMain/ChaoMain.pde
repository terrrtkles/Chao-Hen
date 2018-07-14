nodes body = new nodes(100,100,100,10);
PVector initMouse = new PVector(0,0);
PVector finalMouse = new PVector(0,0);
boolean mouseP = false;
void setup() {
  size(800, 800); //size of the window
  frameRate(100);
  
}

void draw(){
  background(43);
  stroke(255);
  body.move();
  body.show();
  if(mouseP){
    strokeWeight(4 + dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY)/10);
    stroke(0 + dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY), 255 - dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY), 0);
    arrow((int)initMouse.x, (int)initMouse.y, mouseX, mouseY);
  }
}

void mousePressed(){
  mouseP = true;
  initMouse.set(mouseX, mouseY);
}

void mouseReleased(){
  mouseP = false; 
  body.addForce(new PVector((mouseX - initMouse.x)/body.getMass(), (mouseY - initMouse.y)/body.getMass()));
}

//https://forum.processing.org/one/topic/drawing-an-arrow.html
void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 
