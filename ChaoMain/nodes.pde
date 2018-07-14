class nodes{
  PVector pos;
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  PVector jerk = new PVector(0,0);
  int size;
  
    nodes(int initialX, int initialY, int size){
      pos = new PVector(initialX, initialY);
      this.size = size;
    }
    
    void show(){
      ellipse(pos.x, pos.y, size, size);
    }
    
    void move(){
      
    }
}
