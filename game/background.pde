class background{
  PVector backgroundCamera;
  PVector background1Pos;
  PVector background2Pos;
  PVector background3Pos;
  PImage background1;
  PImage background2;
  PImage background3;
  String dragon;

  background(String dragon){
    this.dragon = dragon;
    this.backgroundCamera = new PVector(1, 1, 0);
    this.background1Pos = new PVector(0, 0, 3);
    this.background2Pos = new PVector(0, 0, 2);
    this.background3Pos = new PVector(0, 0, 1);
    
    if (dragon.equals("tim")){
      background1 = loadImage("l0_volcano1.png");
      background2 = loadImage("l1_volcano1.png");
      background3 = loadImage("l2_volcano1.png");
    }
  }
  
  void drawBackground(){
      backgroundCamera.x = player.getX() + player.velocity.x;
      image(background1, parallaxCalc(background1Pos.x, background1Pos.z) , background1Pos.y);
      image(background2, parallaxCalc(background2Pos.x, background2Pos.z) , background2Pos.y);
      image(background3, parallaxCalc(background3Pos.x, background3Pos.z) , background3Pos.y);
  }
  
  float parallaxCalc(float x, float z){ return((x-backgroundCamera.x) / z); }

}
