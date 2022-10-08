enum gameState {
    titleScreen, playerSelect, dragonSelect, dragonConfirm, gamePlay, dead, win
  };
gameState state; //initialised in setup method
player player;
dragon dragon; //initialised in the dragonSelect method
projectile proj;
background bg;
PImage playerIcon;
int menuNavigationIndex;
ArrayList<String> characters = new ArrayList<String>();
ArrayList<String> dragons = new ArrayList<String>();


void setup(){
  size(1040, 480);
  frameRate(30);
  background(0);
  state = gameState.titleScreen;
  player = new player("player", 56, 425, 231, 20);
  bg = new background("null", "player");
  dragons.add("balagos");
  dragons.add("iymrith");
  dragons.add("arngalor");
  menuNavigationIndex = 0;

}

void draw(){
  if (state == gameState.titleScreen){ bg.drawTitleScreen(); }
  else if (state == gameState.dragonSelect || state == gameState.dragonConfirm) { dragonSelect(); }
  else if (state == gameState.dead){ playerDead(); }
  else if (state == gameState.win) { playerWin(); }
  else if (state == gameState.gamePlay){
    bg.drawBackground(player.health, dragon.health);
    player.drawChar();
    dragon.drawChar();
  
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
   else if (key == 'e') { player.attack = true; }
   else if (key == ' ') { //SPACE
       if (state == gameState.titleScreen){ state = gameState.dragonSelect; }
      else if (state == gameState.dragonSelect){ state = gameState.dragonConfirm; }
      else if (state == gameState.gamePlay){ movementControl("jump"); }
      else if(state == gameState.dead || state == gameState.win ) { state = gameState.dragonSelect; }
    }
    else if (key == CODED){
      if (keyCode == LEFT) { 
         if (state == gameState.dragonSelect){ menuNavigationIndex -= 1; }
       }
       else if (keyCode == RIGHT) { 
         if (state == gameState.dragonSelect){ menuNavigationIndex += 1; }
       }
    }
 }
void keyReleased() { movementControl("stop"); }

void dragonSelect(){
  String name;
  if (menuNavigationIndex >= dragons.size()){ menuNavigationIndex = 0; }
  else if (menuNavigationIndex < 0){ menuNavigationIndex = dragons.size() - 1; }
  bg.selectDragon(menuNavigationIndex);
  if (state == gameState.dragonConfirm) { 
    name = dragons.get(menuNavigationIndex);
    dragon = new dragon(name, 680, 100, 400);
    bg = new background(name, "player");
    menuNavigationIndex = 0;
    state = gameState.gamePlay;
    }
}

void playerDead(){
  bg.lose();
  player = new player("player", 56, 425, 231, 20);
}

void playerWin(){
  bg.win();
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
      player.attack = false;
  }
}

void checkCharCollision(dragon one, player two){
  if (one.getX() - two.pos.x < 0){
    if(player.attack == true) { 
      dragon.deductHealth(5);
      player.attack = false;
    } 
  }
}
  
void checkProjCollision(projectile one, player two){
  if (one.getY() + 5 >= 465) { //collision with ground
    if(dragon.attack == true) { 
      one.explode();
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
}
