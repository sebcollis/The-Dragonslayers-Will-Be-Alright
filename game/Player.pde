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
  
  //modify x value
  void moveX(float newX){ this.x = newX; }
  //modify y value
  void moveY(float newY) { this.y = newY; }
  
  void drawChar() { 
    //checking collision w/ walls and floor
    if (this.x <= 1) { this.x = 2; }
    if (this.x >= 500 - size) { this.x = 500 - size - 1; }
    if (this.y <= 1) { this.y = 2; }
    if (this.y >= 300 - size) { this.y = 300 - size - 5;}
    
    //movement
    if (this.left && this.moving){ moveX(this.x - velocity.x); }
    if (this.right && this.moving){ moveX(this.x + velocity.x); }
    if (this.jumping){ 
      if (this.getY() + velocity.y > 276) { //making sure player doesn't clip through the floor
        this.jumping = false;
        velocity.y = -20;
      }
      else {
      moveY(this.getY() + velocity.y); 
      velocity.y += gravity; //yay physics
      }
    }
    
    //actually drawing the player
    rect(x, y, size, size);
 
}

//getters

  float getX() { return this.x; }
  
  float getY() { return this.y; }
  
  float getSize() { return this.size; }
}
