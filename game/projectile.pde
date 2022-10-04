class projectile{
  float x;
  float y;
  boolean exploding;
  PVector velocity = new PVector(1, 0.0002);
  float gravity;
  
  projectile(float x, float y, float grav){
    this.x = x;
    this.y = y;
    this.gravity = grav;
    this.exploding = false;
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void explode() { this.exploding = true; }
  
  void drawProjectile() {
    proj.moveX(proj.getX() - velocity.x);
    proj.moveY(proj.getY() + velocity.y);
    velocity.y += gravity;
    if (exploding == true){}
    else { rect(x, y, 20, 10); } }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
}
