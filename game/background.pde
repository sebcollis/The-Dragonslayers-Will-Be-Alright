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
  PImage dragonSelect1;
  PImage dragonSelect2;
  PImage dragonSelect3;
  PImage dragonIcon1;
  PImage dragonIcon2;
  PImage dragonIcon3;
  PImage win;
  PImage lose;
  PImage[] dragonSelect = new PImage[3];
  String dragon;

  background(String dragon, String player){
    this.dragon = dragon;
    this.backgroundCamera = new PVector(1, 1, 0);
    this.background1Pos = new PVector(0, 0, 3);
    this.background2Pos = new PVector(0, 0, 2);
    this.background3Pos = new PVector(0, 0, 1);
    
    this.backgroundDecor = loadImage("backgroundDecor.png");
    this.titleScreen = loadImage("title.png");
    this.win = loadImage("win.png");
    this.lose = loadImage("lose.png");
    
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
    }
    else if (dragon.equals("iymrith")){
      background1 = loadImage("l0_beach.png");
      background2 = loadImage("l1_beach.png");
      background3 = loadImage("l2_beach.png");
    }
    else if (dragon.equals("arngalor")){
      background1 = loadImage("l0_swamp.png");
      background2 = loadImage("l1_swamp.png");
      background3 = loadImage("l2_swamp.png");
    }

  }
  
  void drawBackground(){
      backgroundCamera.x = player.pos.x + player.velocity.x;
      image(background1, parallaxCalc(background1Pos.x, background1Pos.z) , background1Pos.y);
      image(background2, parallaxCalc(background2Pos.x, background2Pos.z) , background2Pos.y);
      image(background3, parallaxCalc(background3Pos.x, background3Pos.z) , background3Pos.y);
      image(backgroundDecor, 0, 0);
  }
  
  void drawTitleScreen(){ image(titleScreen, 0, 0); }
  
  void selectDragon(int index){
    image(dragonSelect[index], 0, 0);
    image(dragonIcon1, 137, 182);
    image(dragonIcon2, 393, 182);
    image(dragonIcon3, 649, 182);
  }
  
  void win(){ image(win, 0, 0); }
  
  void lose(){ image(lose, 0, 0); }
  
  float parallaxCalc(float x, float z){ return((x-backgroundCamera.x) / z); }

}
