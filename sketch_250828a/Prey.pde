class Prey extends GraphicObject {
  int diameter = 20;

  Prey() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  Prey(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void update(int delta) {
    
  }
  
  void display() {
  }
}
