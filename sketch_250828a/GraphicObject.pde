abstract class GraphicObject {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  color fillColor = color (0, 0, 255);
  color strokeColor = color (0);
  float strokeWeight = 1;
  
  abstract void update(long deltaTime);
  
  abstract void display();
  
}
