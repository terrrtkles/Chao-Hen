class nodes{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector force;
  PVector gravity;
  int size;
  int mass;
  
    nodes(int initialX, int initialY, int size, int mass){
      vel = new PVector(0,0);
      acc = new PVector(0,0);
      gravity = new PVector(0, -9.8);
      
      pos = new PVector(initialX, initialY);
      this.size = size;
      this.mass = mass;
    }
    
    void show(){
      ellipse(pos.x, pos.y, size, size);
    }
    
    void move(boolean acted){
        if(acted){
          
        }else{
          acc = gravity;
          vel.add(acc);
          pos.add(vel);
        }
        
      
    }
    
    void update(boolean x){
      move(x);
    }
    
      
    
    void addForce(PVector force){
      this.force = force;
    }
    
}
