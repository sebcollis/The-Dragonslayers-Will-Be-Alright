class projectile{
  float x;
  float y;
  boolean exploding;
  
  projectile(float x, float y){
    this.x = x;
    this.y = y;
    this.exploding = false;
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void explode() { this.exploding = true; }
  
  void drawProjectile() { rect(x, y, 100, 100); }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
}
