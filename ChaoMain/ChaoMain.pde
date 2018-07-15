import ddf.minim.*;

import controlP5.*;
import java.util.*;

nodes body = new nodes(100,10, "images/suit_shirt.png");
limbs armR = new limbs(5, body, 10, -10, 35, new String[] {"images/armstub1.png"});
limbs armL = new limbs(5, body, -80, -10, 35, new String[] {"images/armstub2.png"});
limbs head = new limbs(1, body, -82, -10, 80, new String[] {"images/hao2_fix.png", "images/hao1_fix.png"});
limbs legR = new limbs(3.5, body, 0, -85, 35, new String[] {"images/legstub1.png"});
limbs legL = new limbs(3.5, body, -70, -85, 35, new String[] {"images/legstub2.png"});
limbs[] parts = {armR, armL, head, legL, legR};
String[][] skins = {new String[] {"images/hao2_fix.png", "images/hao1_fix.png"}, new String[] {"images/blanchard1_fix.png", "images/blanchard2_fix.png"}};

PImage bg;
PImage boom;
Minim minim;
AudioPlayer booms;
AudioPlayer hao;
AudioPlayer blanch;
AudioPlayer[] sounds;
float prevMenu = 0;
float menu = 0.0;
int curSkin = 0;
int superGrav = -1;
int superBounce = -1;

PVector initMouse = new PVector(0,0);
PVector finalMouse = new PVector(0,0);
boolean mouseP = false;
boolean over = false;
boolean move = false;

int num = 2;
int[] x = new int[num];
int[] y = new int[num];

ControlP5 cp5;

void setup() {
  minim = new Minim(this);
  booms = minim.loadFile("boom.mp3");
  hao = minim.loadFile( "wthHao.mp3");
  blanch = minim.loadFile( "IT DEPENDS 2.mp3");
  this.sounds = new AudioPlayer[] {hao, blanch};
  
  size(800, 800); //size of the window
  bg = loadImage("game_bg-default.png");
  frameRate(100);
  
  cp5 = new ControlP5(this);
  cp5.setColorBackground(color(211,211,211, 50));
  List l = Arrays.asList("Fling", "Drag", "'Splody Hands", "Low Gravity", "Super Bounce", "Change Head", "Change Skin");
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
    body.setSound(hao);
    for(limbs limb: parts){
      limb.setIm();
    }
}

void draw(){
  background(bg);
  if(superGrav > 0)
    text("Low Gravity: ON", 570, 100);
  if(superBounce > 0)
    text("Super Bounce: ON", 40, 100);
  stroke(255);
  body.move();
  body.show();
  for(limbs limb: parts){
    limb.update();
    limb.display();
  }
  float points = body.getPoints();
  textSize(20);
  text("POINTS: " + points, 570, 50);
  
  if(menu == 0.0){
    fling();
    prevMenu = menu;
  }
  if(menu == 1.0){
    drag();
    prevMenu = menu;
  }
  if(menu == 2.0){
    splode();
    prevMenu = menu;
  }
  if(menu == 5.0){
    if(curSkin == skins.length -1)
      curSkin = -1;
    curSkin++;
    parts[2].setPath(skins[curSkin]);
    body.setSound(sounds[curSkin]);
    cp5.getController("options").setValue(prevMenu);
    menu = prevMenu;
  }
  if(menu == 3.0){
    if(superGrav <0){
      body.gravity.y = .05;
      superGrav *= -1;
    }else{
      body.gravity.y = .15;
      superGrav *= -1;
    }
    cp5.getController("options").setValue(prevMenu);
    menu = prevMenu;
  }
  if(menu == 4.0){
    if(superBounce <0){
      body.bounce = .8;
      superBounce *= -1;
    }else{
      body.bounce = .5;
      superBounce *= -1;
    }
    cp5.getController("options").setValue(prevMenu);
    menu = prevMenu;
  }
  if(menu == 6){
    String stripper = "images/stripper_torso.png";
    if(!body.p.equals( stripper)){
      body.p= stripper; body.setIm();
  }
    else{
      body.p = "images/suit_shirt.png";
      body.im = loadImage("images/suit_shirt.png");
    }
    cp5.getController("options").setValue(prevMenu);
    menu = prevMenu;
  }
    
}

void controlEvent(ControlEvent theEvent){
  if(theEvent.isController()){
    menu = theEvent.getController().getValue();
  }
}

void mousePressed(){
  mouseP = true;
  initMouse.set(mouseX, mouseY);
  if(menu == 1.0){
    if(over){
      move = true;
    }
  }
}

void mouseReleased(){
  mouseP = false; 
  if(menu == 0.0){
    PVector force = new PVector((mouseX - initMouse.x)/body.getMass(), (mouseY - initMouse.y)/body.getMass());
    body.addForce(force);
  }
  if(menu == 1.0){
    move = false;
    if(over == true && (x[1] != x[0] || y[1] != y[0])){
      PVector force = new PVector(100*(x[1]-x[0])/body.getMass(),100*(y[1]-y[0])/body.getMass());
      body.addForce(force);
    }
  }
}

void fling(){
  if(mouseP){
    strokeWeight(4 + dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY)/10);
    stroke(0 + dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY), 255 - dist((int)initMouse.x, (int)initMouse.y, mouseX, mouseY), 0);
    arrow((int)initMouse.x, (int)initMouse.y, mouseX, mouseY);
  }
}

void drag(){
  int radius = body.getSize()/2;
  if(mouseX > body.getX()-radius && mouseX < radius+body.getX() && mouseY > body.getY()-radius && mouseY < body.getY()+radius){
    over = true;
  }else{
    over = false;
  }
  if(move){
    PVector here = new PVector(mouseX,mouseY);
    body.setPos(here);
    x[0] = x[1];
    y[0] = y[1];
    x[1] = mouseX;
    y[1] = mouseY;
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
  booms.play();
  booms.rewind();
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
