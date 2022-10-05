player player;
dragon dragon;
projectile proj;
background bg;
PImage playerIcon;
ArrayList<String> combos = new ArrayList<String>();

void setup(){
  size(1040, 480);
  frameRate(30);
  background(0);
  player = new player("player", 30, 425, 231, 20);
  dragon = new dragon("tim", 780, 215, 250, 50);
  bg = new background("tim", "player");
  this.playerIcon = loadImage("seb_icon.png");

}

void draw(){
  bg.drawBackground();
  player.drawChar();
  dragon.drawChar();
  image(playerIcon, 60 + (player.health * 14), 50);

  
  //dragon health bar
  //rect(270, 30, dragon.health * 3, 10);
  
  dragon.isDragonAttacking();
  checkCharCollision(dragon, player);
  
}

void keyPressed() {
  if (key == 'a'){
    movementControl("left");
    }
  else if (key == 'd'){
    movementControl("right");
    }
   else if (key == ' ') {
     movementControl("jump");
   }
   else if (key == CODED){
     if (keyCode == LEFT) { attackCombo("left"); }
     else if (keyCode == RIGHT) { attackCombo("right"); }
     else if (keyCode == UP) { attackCombo("up"); }
     else if (keyCode == DOWN) { attackCombo("down"); }
   }
  }
void keyReleased() { movementControl("stop"); }
  
void movementControl(String action){
  if (action.equals("left")){ 
    player.state = animState.moveLeft;
  }
  if (action.equals("right")){ 
    player.state = animState.moveRight;
  }
  if (action.equals("jump")) { player.state = animState.jump; }
  if (action.equals("stop")){
      if (player.state == animState.moveLeft){ player.state = animState.idleLeft; }
      else if (player.state == animState.moveRight){ player.state = animState.idleRight; }
  }
}

void attackCombo(String attack){
  int count = millis();
  if (combos.isEmpty()){
    count = 0;
    if (!attack.equals("null")){ combos.add(attack); }
    count = millis() + 3000;
  }
  else{
    if (!attack.equals("null")){ combos.add(attack); }
    if (millis() >= count){ 
      processAttack(combos);
      println(combos); 
      combos = new ArrayList<String>();
    }
  }
}

void processAttack(ArrayList<String> combos){  
  if (combos.size() == 0) { player.attack = attackState.noAttack; }
  else if (combos.size() == 2) { player.attack = attackState.basicAttack; }
}

void checkCharCollision(dragon one, player two){
  if (one.getX() - two.getX() < 30){
    if(player.attack != attackState.noAttack) { 
      print("Player attacked dragon!");
      dragon.deductHealth(5);
    } 
  }
}
  
void checkProjCollision(projectile one, player two){
  if (one.getY() + 5 >= 465) { 
    if(dragon.attack == true) { 
      one.explode();
      print("Ground hit by projectile!"); }
      dragon.attack = false;
    }
  if (one.getX() - two.getX() + player.velocity.x < player.size && one.getX() - two.getX() + player.velocity.x > 0 && two.getY() - one.getY() + player.velocity.x < player.size){
    if(dragon.attack == true) { 
      one.explode();
      print("Player hit by projectile!");
      player.deductHealth(5); 
    }
     dragon.attack = false;
  }
}
