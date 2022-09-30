Player player;
Char dragon;
projectile proj;
Boolean playerAttack = false;
Boolean dragonAttack = false;

void setup(){
  size(500, 300);
  frameRate(60);
  background(0);
  player = new Player("player", 10, 275, 20);
  dragon = new Char("dragon", 400, 205, 90);
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
    movementControl("left");
    }
  else if (key == 100){ //ascii d
    movementControl("right");
    }
  else if (key == 107){ //ascii k
    movementControl("attack");
    }
   else if (key == 101) { //ascii e
     movementControl("jump");
   }
  }
void keyReleased() { movementControl("stop"); }
  
void movementControl(String action){
  if (action.equals("left")){ 
    player.left = true; 
    player.right = false;
    player.moving = true;
  }
  if (action.equals("right")){ 
    player.right = true;
    player.left = false;
    player.moving = true;
  }
  if (action.equals("jump")) { player.jumping = true; }
  if (action.equals("attack")){ player.attacking = true;}
  if (action.equals("stop")){
      player.moving = false;
      player.attacking = false;
  }
}

void isDragonAttacking(){ //is he?
  if (!dragonAttack) {
    if (random(5) > 4.9){ 
      dragonAttack = true;
      proj = new projectile(dragon.getX(), dragon.getY());
    }
  }
  else {
    proj.drawProjectile();
    checkProjCollision(proj, player);
  }
}

void checkCharCollision(Char one, Player two){
  if (one.getX() - two.getX() + 5 < 30){
    if(player.attacking == true) { print("Player attacked dragon!"); } }
  }
  
void checkProjCollision(projectile one, Player two){
  if (one.getX() - two.getX() + 5 < 30 && two.getY() - one.getY() + 5 < 30){
    if(dragonAttack == true) { 
      one.explode();
      print("Player hit by projectile!"); }
      dragonAttack = false;
    }
}
