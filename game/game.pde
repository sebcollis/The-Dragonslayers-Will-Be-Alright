player player;
dragon dragon;
projectile proj;
Boolean playerAttack = false;
Boolean dragonAttack = false;

void setup(){
  size(500, 300);
  frameRate(60);
  background(0);
  player = new player("player", 10, 275, 20);
  dragon = new dragon("alduin", 400, 205, 90);
}

void draw(){
  background(0);
  player.drawChar();
  dragon.drawChar();
  
  dragon.isDragonAttacking();
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

void checkCharCollision(dragon one, player two){
  if (one.getX() - two.getX() + 5 < 30){
    if(player.attacking == true) { print("Player attacked dragon!"); } }
  }
  
void checkProjCollision(projectile one, player two){
  if (one.getY() + 5 >= 295) { 
    if(dragonAttack == true) { 
      one.explode();
      print("Ground hit by projectile!"); }
      dragonAttack = false;
    }
  if (one.getX() - two.getX() + 5 < 30 && two.getY() - one.getY() + 5 < 30){
    if(dragonAttack == true) { 
      one.explode();
      print("Player hit by projectile!"); }
      dragonAttack = false;
    }
}
