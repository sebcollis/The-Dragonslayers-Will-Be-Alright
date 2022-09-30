class Player{
  String name;
  float x;
  float y;
  float size;
  Boolean left;
  Boolean right;
  Boolean attacking;
  Boolean jumping;
  Boolean up;
  Boolean moving;
  PVector velocity = new PVector(5, -20);
  float gravity = 9.8;
  float jumpHeight = 200;
  
  Player(String name, float x, float y, float size){
    this.name = name;
    this.x = x;
    this.y = y;
    this.size = size;
    this.left = false;
    this.right = false;
    this.jumping = false;
    this.attacking = false;
    this.moving = false;
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void drawChar() { 
    
    if (this.left && this.moving){ moveX(this.x - velocity.x); }
    if (this.right && this.moving){ moveX(this.x + velocity.x); }
    if (this.jumping){ 
      moveY(this.getY() + velocity.y); 
      velocity.y += gravity; 
    }
    
 
    rect(x, y, size, size);
 
}
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
  
  float getSize() { return this.size; }
}
