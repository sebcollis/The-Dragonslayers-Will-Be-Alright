Char player;
Char dragon;
projectile proj;
Boolean playerAttack = false;
Boolean dragonAttack = true;

void setup(){
  size(500, 300);
  frameRate(60);
  background(0);
  player = new Char("player", 10, 275, 20);
  dragon = new Char("dragon", 400, 205, 90);
  proj = new projectile(dragon.getX(), dragon.getY());

}

void draw(){
  background(0);
  player.drawChar();
  dragon.drawChar();
  
  isDragonAttacking();
  checkCharCollision(dragon, player);
  
}

void keyPressed() {
  if (key == 97){ //ascii a
    player.moveX(player.getX() - 5);
    }
  else if (key == 100){ //ascii d
    player.moveX(player.getX() + 5);
    }
  else if (key == 107){ //ascii k
    playerAttack();
    }
  }
  
void playerAttack(){
  playerAttack = true;
}

void isDragonAttacking(){ //is he?
  if (!dragonAttack) {
    if (random(5) > 4.999){ 
      dragonAttack = true;
    }
  }
  else {
    println("proj");
    proj.drawProjectile();
    float velocity = 1;
    float gravity = -9.61;
    proj.moveX(proj.getX() - velocity);
    //proj.moveY(proj.getY() * gravity/5);
    checkProjCollision(player, proj);
  }
}

void checkCharCollision(Char one, Char two){
  if (one.getX() - two.getX() + 5 < 30){
    if(playerAttack == true) { print("Player attacked dragon!"); } }
  }
  
void checkProjCollision(Char one, projectile two){
  if (one.getX() - two.getX() + 5 < 30){
    if(dragonAttack == true) { print("Player hit by projectile!"); } }
}
