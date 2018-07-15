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
  PImage im;
  String[] p;
  nodes parent;
  
  limbs(float m, nodes body, float offX, float offY, float radius, String[] path) {
    offsetX = offX;
    offsetY = offY;
    nodes parent = body;  
    p = path;
    x = parent.pos.x + offsetX + radius;
    y = parent.pos.y - offsetY - radius;
    mass = m;
    this.radius = radius;
    gravity = body.gravity.y;
    p = path;
  }
  
  void setIm(){
    im = loadImage(p[0]);
  }
  
  void update() {
    float targetX = body.pos.x + offsetX + radius;
    float targetY = body.pos.y - offsetY - radius;
    float forceX = (targetX - x) * stiffness;
    float ax = forceX / mass;
    vx = damping * (vx + ax);
    x += vx;
    float forceY = (targetY - y) * stiffness;
    forceY += gravity;
    float ay = forceY / mass;
    vy = damping * (vy + ay);
    y += vy;
    
  }
  
  void display() {
      if(p.length > 1){
        if(sqrt(sq(vx)+sq(vy)) > 5)
          im = loadImage(p[1]);
        else
          im = loadImage(p[0]);
      }
      image(im, x - radius/2, y - radius/2, radius, radius);
  }
  
  void setPath(String[] newP){
    p = newP;
  }
  
  nodes getParent(){
    return parent;
  }
  
}
