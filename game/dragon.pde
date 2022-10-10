class dragon{
  String name;
  float x;
  float y;
  float size;
  float health;
  Boolean attack;
  int frameIndex;
  PImage frame;
  PImage sprites[] = new PImage[100];
  
  dragon(String name, float x, float y, float size){
    this.name = name;
    this.x = x;
    this.y = y;
    this.size = size;
    this.attack = false;
    
    initialiseSprites();
    
    if (name == "balagos"){ health = 50; }
    else if (name == "iymrith"){ health = 100; }
    else if (name == "arngalor"){ health = 200; }
      
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void deductHealth(float deduction){  
    this.health -= deduction; 
    if (this.health < 0){ this.health = 0; }
  }
  
  //is the dragon dead?
  Boolean isDragonDead(){
    if (this.health <= 0){ return true; }
    else { return false; }
  }
  
  void drawChar() {  
    if (this.attack == true){
     if (frameCount % 5 == 0){ //prevents animation playing too fast
      if (frameIndex < 9 || frameIndex > 14){ frameIndex = 9; } //makes sure index isnt out of range
      else if (frameIndex == 14){ frameIndex = 9; } //wraps around to the start of the animation
      else { frameIndex += 1; }
     }
      frame = sprites[frameIndex];
      image(frame, this.x, this.y); //draw the sprite
    }
    else {
      if (frameCount % 2 == 0){ //prevents animation playing too fast
        if (frameIndex < 0 || frameIndex > 8){ frameIndex = 0; } //makes sure index isnt out of range
        else if (frameIndex == 8){ frameIndex = 0; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.x, this.y); //draw the sprite
    }
  }
  
  void isDragonAttacking(){ 
    if (!attack) {
      float rand = random(5);
      if (this.name.equals("balagos")){ //ez difficulty  
        if (rand > 4.6){ attack(); } }
      if (this.name.equals("iymrith")){ //medium difficulty  
        if (rand > 4.2){ attack(); } }
      if (this.name.equals("arngalor")){ //hard difficulty  
        if (rand > 4){ attack(); } }
    }
  else {
    proj.drawProjectile();
    checkProjCollision(proj, player);
  }
 }
 
  void attack() {
    float grav = 0;
    float rand = random(3);
    if (rand >= 2.9){
      specialAttack();
    }
    else{
      if ((rand < 1)) { grav = 0.3; }
      if ((rand < 2 && rand >= 1)) { grav = 0.7; }
      if ((rand < 2.9 && rand >= 2)) { grav = 0.09; }
      attack = true;
      proj = new projectile(dragon.getX() + 40, dragon.getY() + 100, grav, dragon.name);
    }
  }
  
  void specialAttack(){
    player.moveX(player.pos.x - 40);
    player.deductHealth(5);
    println("Special Attack");
  }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
  
  //abandon hope all ye who enter here
  void initialiseSprites(){
    PImage idle = null;
    PImage attack = null;
    if (this.name.equals("balagos")){
      idle = loadImage("balagos_idle.png");
      attack = loadImage("balagos_attack.png");
    }
    else if (this.name.equals("iymrith")) {
      idle = loadImage("iymrith_idle.png");
      attack = loadImage("iymrith_attack.png");
    }
    else if (this.name.equals("arngalor")) {
      idle = loadImage("arngalor_idle.png");
      attack = loadImage("arngalor_attack.png");
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
  }
}
