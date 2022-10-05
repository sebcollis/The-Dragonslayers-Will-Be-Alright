enum gameState {
    startScreen, playerSelect, dragonSelect, dragonConfirm, gamePlay, dead, win
  };
gameState state; //initialised in setup method
player player;
dragon dragon; //initialised in the dragonSelect method
projectile proj;
background bg;
PImage playerIcon;
int menuNavigationIndex;
ArrayList<String> combos = new ArrayList<String>();
ArrayList<String> characters = new ArrayList<String>();
ArrayList<String> dragons = new ArrayList<String>();


void setup(){
  size(1040, 480);
  frameRate(30);
  background(0);
  state = gameState.dragonSelect;
  player = new player("player", 56, 425, 231, 20);
  dragons.add("balagos");
  dragons.add("iymrith");
  dragons.add("arngalor");
  menuNavigationIndex = 0;
  this.playerIcon = loadImage("seb_icon.png");

}

void draw(){
  if (state == gameState.dragonSelect || state == gameState.dragonConfirm) { dragonSelect(); }
  else if (state == gameState.dead){ playerDead(); }
  else if (state == gameState.win) { playerWin(); }
  else if (state == gameState.gamePlay){
    bg.drawBackground();
    player.drawChar();
    dragon.drawChar();
    image(playerIcon, 67 + (player.health * 13), 39); //players icon on the health bar

  
  //dragon health bar
  //rect(270, 30, dragon.health * 3, 10);
  
    dragon.isDragonAttacking();
    checkCharCollision(dragon, player);
    Boolean dead = player.isPlayerDead();
    if (dead == true){ state = gameState.dead; }
    Boolean deadDragon = dragon.isDragonDead();
    if (deadDragon == true){ state = gameState.win; }
  }
  
}

void keyPressed() {
   if (key == 'a'){ movementControl("left"); }
   else if (key == 'd'){ movementControl("right"); }
   else if (key == ' ') { //SPACE
      if (state == gameState.dragonSelect){ state = gameState.dragonConfirm; }
      else if (state == gameState.gamePlay){ movementControl("jump"); }
    }
    else if (key == CODED){
      if (keyCode == LEFT) { 
         if (state == gameState.dragonSelect){ menuNavigationIndex -= 1; }
         else if (state == gameState.gamePlay){ attackCombo("left"); }
       }
       else if (keyCode == RIGHT) { 
         if (state == gameState.dragonSelect){ menuNavigationIndex -= 1; }
         else if (state == gameState.gamePlay){ attackCombo("right"); }
       }
       else if (keyCode == UP) { attackCombo("up"); }
       else if (keyCode == DOWN) { attackCombo("down"); }
     }
 }
void keyReleased() { movementControl("stop"); }

void dragonSelect(){
  String name;
  if (menuNavigationIndex >= dragons.size()){ menuNavigationIndex = 0; }
  else if (menuNavigationIndex < 0){ menuNavigationIndex = dragons.size() - 1; }
    if (state == gameState.dragonConfirm) { 
      name = dragons.get(menuNavigationIndex);
      dragon = new dragon(name, 780, 215, 250);
      bg = new background(name, "player");
      menuNavigationIndex = 0;
      state = gameState.gamePlay;
    }
}

void playerDead(){
  print("oopsy whoopsy");
  player = new player("player", 56, 425, 231, 20);
  state = gameState.dragonSelect;
}

void playerWin(){
  print("huzzah!");
  player = new player("player", 56, 425, 231, 20);
  state = gameState.dragonSelect;
}

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
  if (one.getX() - two.pos.x < 30){
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
  if (one.getX() - two.pos.x + player.velocity.x < player.size && one.getX() - two.pos.x + player.velocity.x > 0 && two.pos.x - one.getY() + player.velocity.x < player.size){
    if(dragon.attack == true) { 
      one.explode();
      print("Player hit by projectile!");
      player.deductHealth(5); 
    }
     dragon.attack = false;
  }
}
