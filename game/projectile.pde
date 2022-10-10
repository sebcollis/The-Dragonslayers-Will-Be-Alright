class projectile{
  float x;
  float y;
  boolean exploding;
  PVector velocity = new PVector(3, 0.0002);
  float gravity;
  PImage frame;
  PImage[] sprites = new PImage[10];
  int frameIndex = 0;
  
  projectile(float x, float y, float grav, String dragon){
    this.x = x;
    this.y = y;
    this.gravity = grav;
    this.exploding = false;
    
    PImage proj = null;
    PImage projExplo = null;
    if (dragon.equals("balagos")){ 
      proj = loadImage("proj_balagos.png"); 
      projExplo = loadImage("proj_balagos_explo.png");
  }
    if (dragon.equals("iymrith")){ 
      proj = loadImage("proj_iymrith.png"); 
      projExplo = loadImage("proj_iymrith_explo.png"); 
  }
    if (dragon.equals("arngalor")){ 
      proj = loadImage("proj_arngalor.png"); 
      projExplo = loadImage("proj_arngalor_explo.png");
  }
    
    int spriteX = 0;
    for (int i = 0; i < 3; i++){
      sprites[i] = proj.get(spriteX, 0, 40, 40); //index 0-2
      spriteX += 40;
    }
    spriteX = 0;
    for (int i = 3; i < 7; i++){
      sprites[i] = projExplo.get(spriteX, 0, 40, 40); //index 0-2
      spriteX += 40;
    }
    
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void explode() { this.exploding = true; }
  
  void drawProjectile() {
    proj.moveX(proj.getX() - velocity.x);
    proj.moveY(proj.getY() + velocity.y);
    velocity.y += gravity;
    
    if (this.getY() + 40 >= 465) { //collision with ground 
      this.moveY(465 - 40);
      this.explode();
    }
    
    println(frameIndex);
    
    if (exploding == true){
      if (frameCount % 4 == 0){
        if (frameIndex < 3 || frameIndex > 6){ frameIndex = 3; } //makes sure index isnt out of range
        else if (frameIndex == 6){ //ends the animation
          dragon.attack = false; 
          frameIndex = 6;
          return;
        } 
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.x, this.y); //draw the sprite
    }
    else { 
      if (frameCount % 4 == 0){
        if (frameIndex < 0 || frameIndex > 2){ frameIndex = 0; } //makes sure index isnt out of range
        else if (frameIndex == 2){ frameIndex = 0; } //wraps around to the start of the animation
        else { frameIndex += 1; }
      }
      frame = sprites[frameIndex];
      image(frame, this.x, this.y); //draw the sprite
    } 
  }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
}
