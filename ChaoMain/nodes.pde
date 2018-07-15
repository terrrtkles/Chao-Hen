 class nodes{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector force;
  PVector gravity;
  float bounce = 0.5;
  float friction = 0.0225;
  int size;
  int mass;
  PImage im;
  String p;
  
    nodes(int size, int mass, String path){
      vel = new PVector(0,0);
      acc = new PVector(0,0);
      gravity = new PVector(0, 0.15);
      pos = new PVector(400, 700);
      force = new PVector(0,0);
      this.size = size;
      this.mass = mass;
      p = path;
    }
    
    void setIm(){
      im = loadImage(p);
    }
    
    void show(){
      strokeWeight(1);
      //ellipse(pos.x, pos.y, size, size);
      fill(43);
      image(im, pos.x - size/2, pos.y - size/2, size, size);
    }
    
    void move(){
        
        if(pos.x >= width-(size + 10)/2){
          vel.x = vel.x * -0.5;
          pos.x = width - (size + 10)/2;
        }else if(pos.x <= (size + 10)/2){
          vel.x = vel.x * -0.5;
          pos.x = (size + 10)/2;
        }
        
        if(pos.y > height-(size + 25)/2 ){
          if(vel.y < 1)
            vel.y = 0;
          vel.y = vel.y * -bounce;
          vel.x = vel.x - (friction*mass*gravity.y)*vel.x;
          pos.y = height - (size + 25)/2;
        }
        if(pos.y < size/2){
          vel.y = vel.y * -bounce;
          pos.y = size/2;
        }
        
        vel.add(gravity);
        vel.add(force);
        vel.limit(50);
        force.set(0,0);
        pos.add(vel);
    }
    
    void addForce(PVector force){
     this.force = force;
    }
    
    void setGravity(float g){
      this.gravity.y = g;
    }
    
    void setPos(PVector pos){
     this.pos = pos;
    }
    
    float getX(){
      return pos.x;
    }
    
    float getY(){
      return pos.y;
    }
    
    PVector getloc(){
      return pos;
    }

    int getMass(){
      return this.mass;
    }
    
    int getSize(){
     return this.size;
    }
}
