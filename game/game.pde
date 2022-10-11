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

/**
  When a key is pressed, it controls either the player or the menu depending what state the game is in.
**/
void keyPressed() {
   if (key == 'a'){  
     if (state == gameState.dragonSelect){ menuNavigationIndex -= 1; }
     else if (state == gameState.gamePlay){ player.state = animState.moveLeft; }
   }
   else if (key == 'd'){
     if (state == gameState.dragonSelect){ menuNavigationIndex += 1; } 
     else if (state == gameState.gamePlay){ player.state = animState.moveRight; }
   }
   else if (key == 'e') { player.state = animState.attacking; }
   else if (key == ' ') { //SPACE
      if (state == gameState.titleScreen){ state = gameState.dragonSelect; }
      else if (state == gameState.dragonSelect){ state = gameState.dragonConfirm; }
      else if (state == gameState.gamePlay){ 
        if (player.state == animState.moveLeft || player.state == animState.idleLeft){ player.state = animState.jumpLeft; }
        else { player.state = animState.jumpRight; }
      }
      else if(state == gameState.dead || state == gameState.win ) { state = gameState.dragonSelect; }
    }
 }
 
 /**
  Controlling key releases to stop movement
**/
void keyReleased() { 
  if (player.state == animState.moveLeft){ player.state = animState.idleLeft; }
  else if (player.state == animState.moveRight){ player.state = animState.idleRight; }
  else if(player.state == animState.attacking) { player.state = animState.idleRight; }
}

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
}

void checkCharCollision(dragon one, player two){
  if (one.getX() - two.pos.x < 0){
    if(player.state == animState.attacking) { 
      dragon.deductHealth(5);
    } 
  }
}
  
void checkProjCollision(projectile one, player two){
  
  if (one.getX() - two.pos.x + player.velocity.x < player.size - 50 && one.getX() - two.pos.x + player.velocity.x > 0 && two.pos.x - one.getY() + player.velocity.x < player.size){
    if(dragon.state == dragonState.attack) { 
      one.explode();
      print("Player hit by projectile!");
      player.deductHealth(5); 
    }
     dragon.state = dragonState.attack;
  }
}
