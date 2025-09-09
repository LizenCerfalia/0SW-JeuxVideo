enum State
{
   WAITING, CHASING
};

class Predator extends GraphicObject {
  int triangleSize;
  int FOV;
  float angle;
  float rotationSpeed;
  float movementSpeed;
  State predatorState;

  Predator(int rotationDirection) {
    triangleSize = 10;
    FOV = normalDistribution(5, 50);
    angle = 0;
    rotationSpeed = random(0.1, 0.2);
    rotationSpeed = rotationSpeed * rotationDirection; 
    movementSpeed = normalDistribution(1, 3);
    predatorState = State.WAITING;
    
    location = new PVector(random(100,700), random(0, 600));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  int normalDistribution (float standardDeviation, float mean) {
     return  int(standardDeviation * randomGaussian() + mean);
  }
  
  void checkEdge() {
    var tempLoc = location.copy().add(velocity);
    
    if (tempLoc.x +  triangleSize / 2 > width - 100 || tempLoc.x - triangleSize / 2 < 100) {
      velocity.x *= 0;
    }
    
    if (tempLoc.y +  triangleSize / 2 > height || tempLoc.y - triangleSize / 2 < 0) {
      velocity.y *= 0;
    }
  }
  
  void seekPlayer(PVector target) {
    //credit: Nature of Code
     PVector desired = PVector.sub(target, location);
     
     desired.normalize();
     desired.mult(movementSpeed);
     
     PVector steer = PVector.sub(desired, velocity);
     
     applyForce(steer);
  }
  
  void applyForce(PVector force) {
    //credit: Nature of Code
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  
  void update(long delta) {
    
    if (predatorState == State.WAITING) {
      angle += rotationSpeed * delta;
    } else {
      velocity.add(acceleration);
      velocity.limit(movementSpeed);
      location.add(velocity);
      acceleration.mult(0);
    }
  }
  
  void display() {
    
    if (predatorState == State.WAITING) {
     pushMatrix();
      stroke(strokeColor);
      fill(255, 0 , 0);
      strokeWeight(strokeWeight);
     
      translate(location.x, location.y);
      rotate(radians(angle));
      
      triangle(triangleSize, -triangleSize * 2, triangleSize * 2, -triangleSize, 0, 0);
     popMatrix();
     pushMatrix();
      noStroke();
      fill(0, 0, 0, 50);     
      
      translate(location.x, location.y);
      rotate(radians(angle));
      
      arc(0, 0, FOV, FOV, 5*PI/12, 13*PI/12);
     popMatrix();
    } else {
      pushMatrix();
      stroke(strokeColor);
      fill(255, 0 , 0);
      strokeWeight(strokeWeight);
     
      translate(location.x, location.y);
      rotate(radians(angle));
      
      triangle(triangleSize, -triangleSize * 2, triangleSize * 2, -triangleSize, 0, 0);
     popMatrix();
     pushMatrix();
      noStroke();
      fill(0, 0, 0, 50);     
      
      translate(location.x, location.y);
      rotate(radians(angle));
      
      arc(0, 0, FOV, FOV, 5*PI/12, 13*PI/12);
     popMatrix();
    }
  }
}
