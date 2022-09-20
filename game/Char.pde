class Char{
  String name;
  float x;
  float y;
  float size;
  
  Char(String name, float x, float y, float size){
    this.name = name;
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void moveX(float newX){ this.x = newX; }
  
  void moveY(float newY) { this.y = newY; }
  
  void drawChar() { rect(x, y, size, size); }
  
  float getX() { return this.x; }
  
  float getY() { return this.y; }
}
