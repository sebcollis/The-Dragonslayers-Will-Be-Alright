class background{
  PVector backgroundCamera;
  PVector background1Pos;
  PVector background2Pos;
  PVector background3Pos;
  PImage background1;
  PImage background2;
  PImage background3;
  PImage backgroundDecor;
  PImage titleScreen;
  PImage instructions;
  PImage dragonSelect1;
  PImage dragonSelect2;
  PImage dragonSelect3;
  PImage dragonIcon1;
  PImage dragonIcon2;
  PImage dragonIcon3;
  PImage dragonIconHealth;
  PImage playerIconHealth;
  PImage win;
  PImage lose;
  PImage[] dragonSelect = new PImage[3];
  String dragon;

  background(String dragon){
    this.dragon = dragon;
    this.backgroundCamera = new PVector(1, 1, 0);
    this.background1Pos = new PVector(0, 0, 3);
    this.background2Pos = new PVector(0, 0, 2);
    this.background3Pos = new PVector(0, 0, 1);
    
    this.backgroundDecor = loadImage("backgroundDecor.png");
    this.titleScreen = loadImage("title.png");
    this.instructions = loadImage("instructions.png");
    this.win = loadImage("win.png");
    this.lose = loadImage("lose.png");
    this.playerIconHealth = loadImage("seb_icon.png");
    
    dragonIcon1 = loadImage("balagos_icon_big.png");
    dragonIcon2 = loadImage("iymrith_icon_big.png");
    dragonIcon3 = loadImage("arngalor_icon_big.png");
    
    dragonSelect1 = loadImage("select_balagos.png");
    dragonSelect2 = loadImage("select_iymrith.png");
    dragonSelect3 = loadImage("select_arngalor.png");
    dragonSelect[0] = dragonSelect1;
    dragonSelect[1] = dragonSelect2;
    dragonSelect[2] = dragonSelect3;
    
    if (dragon.equals("balagos")){
      background1 = loadImage("l0_volcano1.png");
      background2 = loadImage("l1_volcano1.png");
      background3 = loadImage("l2_volcano1.png");
      dragonIconHealth = loadImage("balagos_icon.png");
    }
    else if (dragon.equals("iymrith")){
      background1 = loadImage("l0_beach.png");
      background2 = loadImage("l1_beach.png");
      background3 = loadImage("l2_beach.png");
      dragonIconHealth = loadImage("iymrith_icon.png");
    }
    else if (dragon.equals("arngalor")){
      background1 = loadImage("l0_swamp.png");
      background2 = loadImage("l1_swamp.png");
      background3 = loadImage("l2_swamp.png");
      dragonIconHealth = loadImage("arngalor_icon.png");
    }

  }
 
/**
  Draws the background during gameplay
**/
  void drawBackground(float playerHealth, float dragonHealth){
      backgroundCamera.x = player.pos.x + player.velocity.x;
      image(background1, parallaxCalc(background1Pos.x, background1Pos.z) , background1Pos.y);
      image(background2, parallaxCalc(background2Pos.x, background2Pos.z) , background2Pos.y);
      image(background3, parallaxCalc(background3Pos.x, background3Pos.z) , background3Pos.y);
      image(backgroundDecor, 0, 0);
      image(playerIconHealth, 67 + (playerHealth * 13), 39); //players icon on the health bar
      if (dragon.equals("balagos")){ image(dragonIconHealth, 640 + (dragonHealth * 5.7), 39); } //dragons icon on the health bar
      else if (dragon.equals("iymrith")){ image(dragonIconHealth, 655 + (dragonHealth * 2.7), 39); }
      else if (dragon.equals("arngalor")){ image(dragonIconHealth, 665 + (dragonHealth * 1.3), 39); }
  }
 
/**
  Draws the title screen
**/
  void drawTitleScreen(){ image(titleScreen, 0, 0); }

/**
  Draws the select dragon screen
**/
  void selectDragon(int index){
    image(dragonSelect[index], 0, 0);
    image(dragonIcon1, 137, 182);
    image(dragonIcon2, 393, 182);
    image(dragonIcon3, 649, 182);
  }
  
/**
  Draws the win screen
**/
  void win(){ image(win, 0, 0); }
  
/**
  Draws the lose screen
**/
  void lose(){ image(lose, 0, 0); }
  
/**
  Draws the instructions screen
**/
  void instructions() { image(instructions, 0, 0); }
  
/**
  Calculates the parallax effect for the background
  Xposition divided by Zposition creates parallax effect
  Zposition = distance from the camera
**/
  float parallaxCalc(float x, float z){ return((x-backgroundCamera.x) / z); }

}
