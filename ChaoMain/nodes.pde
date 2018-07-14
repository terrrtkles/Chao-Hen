class nodes{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector force;
  PVector gravity;
  float bounce = 0.6;
  int size;
  int mass;
  
    nodes(int initialX, int initialY, int size, int mass){
      vel = new PVector(1.4,2);
      acc = new PVector(0,0);
      gravity = new PVector(0, 0.2);
      pos = new PVector(initialX, initialY);
      force = new PVector(0,0);
      this.size = size;
      this.mass = mass;
    }
    
    void show(){
      strokeWeight(1);
      ellipse(pos.x, pos.y, size, size);
    }
    
    void move(){
        pos.add(vel);
        vel.add(gravity);
        vel.add(force);
        vel.limit(20);
        if(pos.x > width-(size)/2 || pos.x < size/2){
          vel.x = vel.x * -1;
        }
        if(pos.y > height-(size)/2 ){
          vel.y = vel.y * -bounce;
          vel.x = vel.x * .75;
          pos.y = height-size/2;
        }
        if(pos.y < size/2){
          vel.y = vel.y * -bounce;
          pos.y = size/2;
        }

        force.set(0,0);
        
    }
      
    
    void addForce(PVector force){
      this.force = force;
    }
    
}
