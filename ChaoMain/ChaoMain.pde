import controlP5.*;
import java.util.*;

nodes body = new nodes(100,10, "images/suit_shirt.png");
limbs armR = new limbs(5, body, 10, -10, 35, new String[] {"images/armstub1.png"});
limbs armL = new limbs(5, body, -105, -40, 55, new String[] {"images/suit_larm.png"});
limbs head = new limbs(1, body, -82, -10, 80, new String[] {"images/hao2_fix.png", "images/hao1_fix.png"});
limbs legR = new limbs(3.5, body, 0, -75, 30, new String[] {"images/suit_rpantfix.png"});
limbs legL = new limbs(3.5, body, -60, -75, 30, new String[] {"images/suit_lpantfix.png"});
limbs[] parts = {armR, armL, head, legL, legR};

PImage bg;
PImage boom;
float menu = 0.0;

PVector initMouse = new PVector(0,0);
PVector finalMouse = new PVector(0,0);
boolean mouseP = false;

ControlP5 cp5;

void setup() {
  size(800, 800); //size of the window
  bg = loadImage("game_bg-default.png");
  frameRate(100);
  
  cp5 = new ControlP5(this);
  cp5.setColorBackground(color(211,211,211, 50));
  List l = Arrays.asList("Fling", "Drag", "'Splody Hands", "Change Skin", "Add Text");
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("options")
    .setOpen(false)
    .setPosition(30, 30)
    .setSize(200, 400)
    .setBarHeight(30)
    .setItemHeight(30)
    .addItems(l)
    .setColorValue(0xff2b2b2b)
    .setFont(createFont("gadugi",12))
    .setBackgroundColor(0x00FFFFFF);
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;
    
    cp5.getController("options").getCaptionLabel().setColor(color(0xff2b2b2b) );
    body.setIm();
    for(limbs limb: parts){
      limb.setIm();
    }
}

void draw(){
  background(bg);
  stroke(255);
  body.move();
  body.show();
  for(limbs limb: parts){
    limb.update();
    limb.display();
  }
  
  if(menu == 0.0){
    fling();
  }
  /*if(menu == 1.0){
    drag();
  }*/
  if(menu == 2.0){
    splode();
  }
}

void controlEvent(ControlEvent theEvent){
  if(theEvent.isController()){
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    menu = theEvent.getController().getValue();
  }
}

void mousePressed(){
  mouseP = true;
  initMouse.set(mouseX, mouseY);
}

void mouseReleased(){
  mouseP = false; 
  if(menu == 0.0){
  PVector force = new PVector((mouseX - initMouse.x)/body.getMass(), (mouseY - initMouse.y)/body.getMass());
  body.addForce(force);
  }
}

void fling(){
  if(mouseP){
    strokeWeight(4 + dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY)/10);
    stroke(0 + dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY), 255 - dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY), 0);
    arrow((int)initMouse.x, (int)initMouse.y, mouseX, mouseY);
  }
}

void splode(){
  if(mouseP){
  float pow = 150000;
  float xx = body.getX() - initMouse.x;
  float yy = body.getY() - initMouse.y;
  PVector shat = new PVector((xx)/sqrt(sq(xx)+sq(yy)), (yy)/sqrt(sq(xx)+sq(yy)));
  PVector forcepow = new PVector((pow*shat.x)/((sq(xx)+sq(yy)*body.getMass())),(pow*shat.y)/((sq(xx)+sq(yy))*body.getMass()));
  body.addForce(forcepow);
  
  boom = loadImage("boom.png");
  image(boom,mouseX-100,mouseY-100,200,200);
  }
}

//https://forum.processing.org/one/topic/drawing-an-arrow.html
void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  if(x1 > x2){
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x2-x1, y1-y2);
  rotate(a);
  line(0, 0, (x2-x1)/3, (x1-x2)/3);
  line(0, 0, (x1-x2)/3, (x1-x2)/3);
  popMatrix();
  }
  else {
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, (x2-x1)/3, (x1-x2)/3);
  line(0, 0, (x1-x2)/3, (x1-x2)/3);
  popMatrix();
  }
} 
