Char player;
Char dragon;
Boolean playerAttack = false;

void setup(){
  size(500, 300);
  frameRate(60);
  background(0);
  player = new Char("player", 10, 275, 20);
  dragon = new Char("dragon", 400, 205, 90);
}

void draw(){
  background(0);
  player.drawChar();
  dragon.drawChar();
  
  isDragonAttacking();
  checkCollision(dragon, player);
  
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
  if (random(5) > 4.999){ print("Dragon is attacking!"); }
}

void checkCollision(Char one, Char two){
  if (one.getX() - two.getX() + 5 < 30){
    if(playerAttack == true) { print("Player attacked dragon!"); }
}
}
