player player;
dragon dragon;
projectile proj;
ArrayList<String> combos = new ArrayList<String>();

void setup(){
  size(500, 300);
  frameRate(60);
  background(0);
  player = new player("player", 10, 275, 20);
  dragon = new dragon("tim", 400, 205, 90);
}

void draw(){
  background(0);
  player.drawChar();
  dragon.drawChar();
  
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
      player.state = animState.idleLeft;
  }
}

void attackCombo(String attack){
  int count = 0;
  if (combos.isEmpty()){
    combos.add(attack);
    count = millis() + 3000;
  }
  else {
    combos.add(attack);
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
    if(player.attack != attackState.noAttack) { print("Player attacked dragon!"); } }
  }
  
void checkProjCollision(projectile one, player two){
  if (one.getY() + 5 >= 295) { 
    if(dragon.attack == true) { 
      one.explode();
      print("Ground hit by projectile!"); }
      dragon.attack = false;
    }
  if (one.getX() - two.getX() + 5 < 30 && two.getY() - one.getY() + 5 < 30){
    if(dragon.attack == true) { 
      one.explode();
      print("Player hit by projectile!"); }
      dragon.attack = false;
    }
}
