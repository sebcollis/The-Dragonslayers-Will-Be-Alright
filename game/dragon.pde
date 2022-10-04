class dragon{
  String name;
  float x;
  float y;
  float size;
  Boolean attack;
  
  dragon(String name, float x, float y, float size){
    this.name = name;
    this.x = x;
    this.y = y;
    this.size = size;
    this.attack = false;
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void drawChar() { rect(x, y, size, size); }
  
  void isDragonAttacking(){ 
    if (!attack) {
      float rand = random(5);
      if (this.name.equals("alduin")){ //ez difficulty  
        if (rand > 4.99){ attack(); } }
      if (this.name.equals("throckmorton")){ //medium difficulty  
        if (rand > 4.6){ attack(); } }
      if (this.name.equals("tim")){ //hard difficulty  
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
    if ((rand < 1)) { grav = 0.003; }
    if ((rand < 2 && rand >= 1)) { grav = 0.007; }
    if ((rand < 3 && rand >= 2)) { grav = 0.0009; }
    attack = true;
    proj = new projectile(dragon.getX(), dragon.getY(), grav);
  }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
}
