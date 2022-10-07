enum animState {
    idleLeft, idleRight, moveLeft, moveRight, jump
  };

class player{
  animState state = animState.idleLeft;
  String name;
  PVector pos = new PVector(0, 0);
  float size;
  float health;
  Boolean attack;
  PVector velocity = new PVector(5, -20);
  float gravity = 9.8;
  float jumpHeight = 200;
  PImage[] sprites = new PImage[100];
  PImage frame;
  int frameIndex = 0;
  
  player(String name, float x, float y, float size, float health){
    this.name = name;
    this.pos.x = x;
    this.pos.y = y;
    this.size = size;
    this.health = health;
    this.attack = false;
    
    initialiseSprites();

  }
  
  //modify x value
  void moveX(float newX){ this.pos.x = newX; }
  //modify y value
  void moveY(float newY){ this.pos.y = newY; }
  //modify health
  void deductHealth(float deduction){  
    this.health -= deduction; 
    if (this.health < 0){ this.health = 0; }
  }
  //is the player dead?
  Boolean isPlayerDead(){
    if (this.health <= 0){ return true; }
    else { return false; }
  }
  
  void drawChar() { 
    
    //checking collision w/ walls and floor
    if (this.pos.x <= 10) { this.pos.x = 10; }
    if (this.pos.x >= 1040 - size) { this.pos.x = 1040 - size - 1; }
    if (this.pos.y <= 1) { this.pos.y = 2; }
    if (this.pos.y >= 480 - size) { this.pos.y = 480 - size - 15;}
    
    //checking collision w/ dragon
    if (780 - this.pos.x + velocity.x < 20){ this.pos.x = 740 - size + velocity.x; }
    
    //movement
    if (state == animState.moveLeft){ moveX(this.pos.x - velocity.x); }
    if (state == animState.moveRight){ moveX(this.pos.x + velocity.x); }
    if (state == animState.jump){ 
      if (this.pos.y + velocity.y > 466) { //making sure player doesn't clip through the floor
        state = animState.idleLeft;
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
    
    else{  }
 
}

  //abandon hope all ye who enter here
  void initialiseSprites(){
    PImage idleLeft = loadImage("seb_idle_left.png");
    PImage idleRight = loadImage("seb_idle_right.png");
    PImage runLeft = loadImage("seb_run.png");
    PImage runRight = loadImage("seb_run_right.png");
    
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
      sprites[i+17] = runRight.get(x, y, 224, 224); //right idle = sprite collection index 17-22
      x = x + 224;
    }
  }
   
}
