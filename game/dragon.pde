class dragon{
  String name;
  float x;
  float y;
  float size;
  float health;
  Boolean attack;
  
  dragon(String name, float x, float y, float size){
    this.name = name;
    this.x = x;
    this.y = y;
    this.size = size;
    this.attack = false;
    
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
    rect(x, y, size, size); 
  }
  
  void isDragonAttacking(){ 
    if (!attack) {
      float rand = random(5);
      if (this.name.equals("balagos")){ //ez difficulty  
        if (rand > 4.99){ attack(); } }
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
 
  void attack() {
    float grav = 0;
    float rand = random(3);
    if (rand >= 2.9){
      specialAttack();
    }
    else{
      if ((rand < 1)) { grav = 0.003; }
      if ((rand < 2 && rand >= 1)) { grav = 0.007; }
      if ((rand < 2.9 && rand >= 2)) { grav = 0.0009; }
      attack = true;
      proj = new projectile(dragon.getX(), dragon.getY(), grav);
    }
  }
  
  void specialAttack(){
    player.moveX(player.pos.x - 40);
    player.deductHealth(5);
    println("Special Attack");
  }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
}
