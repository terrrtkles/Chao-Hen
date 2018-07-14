class limbs{
  float vx, vy; // The x- and y-axis velocities
  float x, y; // The x- and y-coordinates
  float gravity;
  float mass;
  float stiffness = 0.7;
  float damping = 0.7;
  float radius;
  float offsetX;
  float offsetY;
  nodes parent;
  
  limbs(float m, nodes body, float offX, float offY, float radius) {
    offsetX = offX;
    offsetY = offY;
    nodes parent = body;  
    x = parent.pos.x + offsetX + radius;
    y = parent.pos.y - offsetY - radius;
    mass = m;
    this.radius = radius;
    gravity = body.gravity.y;
  }
  
  void update() {
    float targetX = body.pos.x + offsetX + radius;
    float targetY = body.pos.y - offsetY - radius;
    float forceX = (targetX - x) * stiffness;
    float ax = forceX / mass;
    vx = damping * (vx + ax);
    vx = constrain(vx, -20, 20);
    x += vx;
    float forceY = (targetY - y) * stiffness;
    forceY += gravity;
    float ay = forceY / mass;
    vy = damping * (vy + ay);
    vy = constrain(vy, -20, 20);
    y += vy;
    
  }
  
  void display() {
      strokeWeight(1);
      ellipse(x, y, radius, radius);
  }
  nodes getParent(){
    return parent;
  }
}
