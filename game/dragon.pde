enum dragonState {
    idle, attack, specialAttack
  };
class dragon{
  dragonState state = dragonState.idle;
  String name;
  PVector pos = new PVector(0, 0);
  float size;
  float health;
  int frameIndex;
  PImage frame;
  PImage sprites[] = new PImage[23];
  
  dragon(String name, float x, float y, float size){
    this.name = name;
    this.pos.x = x;
    this.pos.y = y;
    this.size = size;
    
    initialiseSprites();
    
    if (name == "balagos"){ health = 50; }
    else if (name == "iymrith"){ health = 100; }
    else if (name == "arngalor"){ health = 200; }
      
  }
 
/**
  Moves x and y positions
**/
  void moveX(float newX){ this.pos.x = newX; }
  void moveY(float newY) { this.pos.y = newY; }
  
/**
  Deducts dragon health
**/
  void deductHealth(float deduction){  
    this.health -= deduction; 
    if (this.health < 0){ this.health = 0; }
  }
  
/**
  Checks if dragon health is 0
  If so, dragon is dead
**/
  Boolean isDragonDead(){
    if (this.health <= 0){ return true; }
    else { return false; }
  }
  
/**
  Draws the dragon
**/
  void drawChar() {  
    if (state == dragonState.attack){
     if (frameCount % 5 == 0){ //prevents animation playing too fast
      if (frameIndex < 9 || frameIndex > 14){ frameIndex = 9; } //makes sure index isnt out of range
      else if (frameIndex == 14){ frameIndex = 9; } //wraps around to the start of the animation
      else { frameIndex += 1; }
     }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    else if (state == dragonState.idle){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 0 || frameIndex > 8){ frameIndex = 0; } //makes sure index isnt out of range
        else if (frameIndex == 8){ frameIndex = 0; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
    else if (state == dragonState.specialAttack){
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 15 || frameIndex > 22){ frameIndex = 15; } //makes sure index isnt out of range
        else if (frameIndex == 22){ state = dragonState.idle; } //ends the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.pos.x, this.pos.y); //draw the sprite
    }
  }
  
/**
  Checks if dragon is attacking
  If not, generates a random number to see if dragon should attack
  If yes, moves the projectile and checks to see if it is colliding with the player
**/
  void isDragonAttacking(){ 
    if (state == dragonState.idle || state == dragonState.specialAttack ) {
      float rand = random(5);
      if (this.name.equals("balagos")){ //ez difficulty  
        if (rand > 4.9){ attack(); } }
      if (this.name.equals("iymrith")){ //medium difficulty  
        if (rand > 4.6){ attack(); } }
      if (this.name.equals("arngalor")){ //hard difficulty  
        if (rand > 4){ attack(); } }
    }
  else {
    proj.drawProjectile();
    checkProjCollision(proj, player);
  }
 }
 
/**
  If the player is far away from the dragon, generate a fireball with randomly generated gravity
  If not, special attack (push the player away)
**/
  void attack() {
    float grav = 0;
    float rand = random(3);
    if (player.pos.x >= 600){
      state = dragonState.specialAttack;
      specialAttack();
    }
    else{
      if ((rand < 1)) { grav = 0.3; }
      if ((rand < 2 && rand >= 1)) { grav = 0.7; }
      if ((rand <= 3 && rand >= 2)) { grav = 0.09; }
      state = dragonState.attack;
      proj = new projectile(dragon.pos.x + 40, dragon.pos.y + 100, grav, dragon.name);
    }
  }

/**
  Pushes the player away from the dragon
**/
  void specialAttack(){
    player.moveX(player.pos.x - 300);
  }
  
  
/**
  Loads sprites from spritesheets into sprite array
**/
  void initialiseSprites(){
    PImage idle = null;
    PImage attack = null;
    PImage specialAttack = null;
    if (this.name.equals("balagos")){
      idle = loadImage("balagos_idle.png");
      attack = loadImage("balagos_attack.png");
      specialAttack = loadImage("balagos_attack_special.png");
    }
    else if (this.name.equals("iymrith")) {
      idle = loadImage("iymrith_idle.png");
      attack = loadImage("iymrith_attack.png");
      specialAttack = loadImage("iymrith_attack_special.png");
    }
    else if (this.name.equals("arngalor")) {
      idle = loadImage("arngalor_idle.png");
      attack = loadImage("arngalor_attack.png");
      specialAttack = loadImage("arngalor_attack_special.png");
    }
    
    Integer x = 0;
    Integer y = 0;
    for(int i = 0; i < 9; i++){
      sprites[i] = idle.get(x, y, 400, 376); //idle = sprite collection index 0-8
      x = x + 400;
    }
    x = 0;
    for(int i = 0; i < 6; i++){
      sprites[i+9] = attack.get(x, y, 400, 376); //attack= sprite collection index 9-14
      x = x + 400;
    }
    x = 0;
    for(int i = 0; i < 8; i++){
      sprites[i+15] = specialAttack.get(x, y, 400, 376); //attack= sprite collection index 15-22
      x = x + 400;
    }
  }
}
