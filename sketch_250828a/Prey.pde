class Prey extends GraphicObject {
  int diameter = 40;

  Prey() {
    location = new PVector(40, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  Prey(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void checkEdge() {
    var tempLoc = location.copy().add(velocity);
    
    if (tempLoc.x +  diameter / 2 > width || tempLoc.x - diameter / 2 < 0) {
      velocity.x *= 0;
    }
    
    if (tempLoc.y +  diameter / 2 > height || tempLoc.y - diameter / 2 < 0) {
      velocity.y *= 0;
    }
  }
  
  void update(long delta) {
    checkEdge();
    velocity.add(acceleration); // Accélération
    location.add(velocity);
    velocity.x = 0;
    velocity.y = 0;
  }
  
  void display() {
    stroke(strokeColor);
    fill(fillColor);
    strokeWeight(strokeWeight);

    ellipse(location.x, location.y, diameter, diameter);
  }
}
