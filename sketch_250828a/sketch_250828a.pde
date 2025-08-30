long currentTime;
long previousTime;
long deltaTime;

boolean won = false;
Prey prey;

void setup() {
  size(800,600);
  background(255, 180, 0);
  fill(0,150,0);
  rect(0,0,100,600);
  fill(0,150,0);
  rect(700,0,100,600);
  
  currentTime = millis();
  previousTime = millis();
  
  prey = new Prey();
}

void draw () {
  timeManagement();
  update(deltaTime);
  display();
  
  winCondition();
}

void update(long delta) {
  // Mettre les calculs ici
  
  prey.update(delta);
}

void display () {
  // Mettre le code d'affichage ici
  background(255, 180, 0);
  fill(0,150,0);
  rect(0,0,100,600);
  fill(0,150,0);
  rect(700,0,100,600);
  
  prey.display();
}

void timeManagement (){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
}

void winCondition() {
  if (!won && prey.location.x > 700) {
    println("You win!");
    won = true;
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    prey.location.y -= 4; 
  }
  else if (key == 'a' || key == 'A') {
    prey.location.x -= 4;
  }
  else if (key == 's' || key == 'S') {
    prey.location.y += 4;
  }
  else if (key == 'd' || key == 'D') {
    prey.location.x += 4;
  }
}
