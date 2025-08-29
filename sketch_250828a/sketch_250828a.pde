long currentTime;
long previousTime;
long deltaTime;
char value;

Prey prey;

void keyPressed() {
  if (value == 'w') {
    prey.location.y -= 1; 
  }
  else if (value == 'a') {
    prey.location.x -= 1;
  }
  else if (value == 's') {
    prey.location.y += 1;
  }
  else if (value == 'd') {
    prey.location.x += 1;
  }
}

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
  prey.velocity.x = 2;
  prey.velocity.y = -1;
}

void draw () {
  timeManagement();
  update(deltaTime);
  display();
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
  
  fill (0, 0, 255);
  ellipse (width/2, height/2 , 10, 10);
}

void timeManagement (){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
}
