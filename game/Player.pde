enum animState {
    idleLeft, idleRight, moveLeft, moveRight, jump
  };
enum attackState {
  noAttack, basicAttack, attackOne, attackTwo
  };

class player{
  animState state = animState.idleLeft;
  attackState attack = attackState.noAttack;
  String name;
  PVector pos = new PVector(0, 0);
  float size;
  PVector velocity = new PVector(5, -20);
  float gravity = 9.8;
  float jumpHeight = 200;
  
  player(String name, float x, float y, float size){
    this.name = name;
    this.pos.x = x;
    this.pos.y = y;
    this.size = size;

  }
  
  //modify x value
  void moveX(float newX){ this.pos.x = newX; }
  //modify y value
  void moveY(float newY) { this.pos.y = newY; }
  
  void drawChar() { 
    //checking collision w/ walls and floor
    if (this.pos.x <= 1) { this.pos.x = 2; }
    if (this.pos.x >= 500 - size) { this.pos.x = 500 - size - 1; }
    if (this.pos.y <= 1) { this.pos.y = 2; }
    if (this.pos.y >= 300 - size) { this.pos.y = 300 - size - 5;}
    
    //checking collision w/ dragon
    if (400 - this.getX() + 5 < 30){ this.pos.x = 400 - size; }
    
    //movement
    if (state == animState.moveLeft){ moveX(this.pos.x - velocity.x); }
    if (state == animState.moveRight){ moveX(this.pos.x + velocity.x); }
    if (state == animState.jump){ 
      if (this.getY() + velocity.y > 276) { //making sure player doesn't clip through the floor
        state = animState.idleLeft;
        velocity.y = -20;
      }
      else {
      moveY(this.getY() + velocity.y); 
      velocity.y += gravity; //yay physics
      }
    }
    
    //actually drawing the player
    rect(pos.x, pos.y, size, size);
 
}

//getters

  float getX() { return this.pos.x; }
  
  float getY() { return this.pos.y; }
  
  float getSize() { return this.size; }
}
