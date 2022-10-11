enum animState {
    idleLeft, idleRight, moveLeft, moveRight, jumpLeft, jumpRight, attacking
  };

class player{
  animState state = animState.idleLeft;
  String name;
  PVector pos = new PVector(0, 0);
  float size;
  float health;
  PVector velocity = new PVector(5, -20);
  float gravity = 9.8;
  float jumpHeight = 200;
  PImage[] sprites = new PImage[45];
  PImage frame;
  int frameIndex = 0;
  
  player(String name, float x, float y, float size, float health){
    this.name = name;
    this.pos.x = x;
    this.pos.y = y;
    this.size = size;
    this.health = health;
    
    initialiseSprites();

  }
  
/**
  Moves x and y positions
**/
  void moveX(float newX){ this.pos.x = newX; }
  void moveY(float newY){ this.pos.y = newY; }

/**
  Deducts player health
**/
  void deductHealth(float deduction){  
    this.health -= deduction; 
    if (this.health < 0){ this.health = 0; }
  }

/**
  Checks if player health is 0
  If so, player is dead
**/
  Boolean isPlayerDead(){
    if (this.health <= 0){ return true; }
    else { return false; }
  }
  
/**
  Draws the player
**/
  void drawChar() { 
    
    //checking collision w/ walls and floor
    if (this.pos.x <= 10) { this.pos.x = 10; }
    if (this.pos.x >= 1040 - size) { this.pos.x = 1040 - size - 1; }
    if (this.pos.y <= 1) { this.pos.y = 2; }
    if (this.pos.y >= 480 - size) { this.pos.y = 480 - size - 15;}
    
    //checking collision w/ dragon
    if (780 - this.pos.x + velocity.x < 60){ this.pos.x = this.pos.x - velocity.x; }
    
    //movement
    if (state == animState.moveLeft){ moveX(this.pos.x - velocity.x); }
    if (state == animState.moveRight){ moveX(this.pos.x + velocity.x); }
    if (state == animState.jumpLeft || state == animState.jumpRight){ 
      if (this.pos.y + velocity.y > 290) { //making sure player doesn't clip through the floor
        state = animState.idleRight;
        velocity.y = -20;
      }
      else {
      moveY(this.pos.y + velocity.y);
      velocity.y += gravity; //yay physics
      }
    }
    
    //actually drawing the player
    if(state == animState.idleLeft){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 0 || frameIndex > 4){ frameIndex = 0; } //makes sure index isnt out of range
        else if (frameIndex == 4){ frameIndex = 0; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    if(state == animState.idleRight){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 4 || frameIndex > 9){ frameIndex = 5; } //makes sure index isnt out of range
        else if (frameIndex == 9){ frameIndex = 5; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    if(state == animState.moveLeft){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 10 || frameIndex > 16){ frameIndex = 10; } //makes sure index isnt out of range
        else if (frameIndex == 16){ frameIndex = 10; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    if(state == animState.moveRight){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 17 || frameIndex > 22){ frameIndex = 17; } //makes sure index isnt out of range
        else if (frameIndex == 22){ frameIndex = 17; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    if(state == animState.attacking){
      if (frameIndex < 22 || frameIndex > 28){ frameIndex = 23; } //makes sure index isnt out of range
      else if (frameIndex == 28){ frameIndex = 23; } //wraps around to the start of the animation
      else { frameIndex += 1; }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    if(state == animState.jumpLeft){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 30 || frameIndex > 36){ frameIndex = 30; } //makes sure index isnt out of range
        else if (frameIndex == 36){ frameIndex = 30; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    if(state == animState.jumpRight){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 37 || frameIndex > 44){ frameIndex = 37; } //makes sure index isnt out of range
        else if (frameIndex == 44){ frameIndex = 37; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }

}

/**
  Loads sprites from spritesheets into sprite array
**/
  void initialiseSprites(){
    PImage idleLeft = loadImage("seb_idle_left.png");
    PImage idleRight = loadImage("seb_idle_right.png");
    PImage runLeft = loadImage("seb_run.png");
    PImage runRight = loadImage("seb_run_right.png");
    PImage attack = loadImage("seb_attack.png");
    PImage jumpLeft = loadImage("seb_jump_left.png");
    PImage jumpRight = loadImage("seb_jump_right.png");
    
    Integer x = 0;
    Integer y = 0;
    for(int i = 0; i < 5; i++){
      sprites[i] = idleLeft.get(x, y, 224, 224); //left idle = sprite collection index 0-4
      sprites[i+5] = idleRight.get(x, y, 224, 224); //right idle = sprite collection index 5-9
      x = x + 224;
    }
    x = 0;
    for(int i = 0; i < 7; i++){
      sprites[i+10] = runLeft.get(x, y, 224, 224); //left run= sprite collection index 10-16
      sprites[i+17] = runRight.get(x, y, 224, 224); //right run = sprite collection index 17-22
      sprites[i + 23] = attack.get(x, y, 224, 224); //attack = sprite collection index 23-29
      x = x + 224;
    }
      x = 0;
    for(int i = 0; i < 8; i++){
      sprites[i+30] = jumpLeft.get(x, y, 224, 224); //left run= sprite collection index 30-36
      sprites[i+37] = jumpRight.get(x, y, 224, 224); //right run = sprite collection index 37-44
      x = x + 224;
    }
  }
   
}
