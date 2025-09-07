long currentTime;
long previousTime;
long deltaTime;


Prey prey;
Predator[] predators;

int predatorAmount;
float movementSpeed = 4.5;
boolean won = false;

void setup() {
  size(800,600);
  background(255, 180, 0);
  fill(0,150,0);
  rect(0,0,100,600);
  fill(0,150,0);
  rect(700,0,100,600);
  
  predatorAmount = int(random(10, 15));
  predators = new Predator[predatorAmount];
  
  currentTime = millis();
  previousTime = millis();
  
  prey = new Prey();
  for (int i = 0; i < predatorAmount; i++) {
    if (i < predatorAmount * 80 / 100) { 
      predators[i] = new Predator(1);
    } else {
      predators[i] = new Predator(-1);
    }
  }
}

void restart() {
  background(255, 180, 0);
  fill(0,150,0);
  rect(0,0,100,600);
  fill(0,150,0);
  rect(700,0,100,600);
  
  predatorAmount = int(random(10, 15));
  predators = new Predator[predatorAmount];
  
  currentTime = millis();
  previousTime = millis();
  
  prey = new Prey();
  for (int i = 0; i < predatorAmount; i++) {
    if (i < predatorAmount * 80 / 100) { 
      predators[i] = new Predator(1);
    } else {
      predators[i] = new Predator(-1);
    }
  }
}

void draw () {
  timeManagement();
  update(deltaTime);
  display();
  
  if (keyPressed) {
   actions(); 
  } else {
    prey.velocity.x = 0;
    prey.velocity.y = 0;
  }
  
  winCondition();
}

void update(long delta) {
  // Mettre les calculs ici
  
  prey.update(delta);
  for (int i = 0; i < predatorAmount; i++) {
    predators[i].update(delta);
  }
}

void display () {
  // Mettre le code d'affichage ici
  background(255, 180, 0);
  fill(0,150,0);
  rect(0,0,100,600);
  fill(0,150,0);
  rect(700,0,100,600);
  
  prey.display();
  for (int i = 0; i < predatorAmount; i++) {
    predators[i].display();
  }
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

void actions() {
  if ((key == 'w' || key == 'W')) {
    prey.velocity.y = -movementSpeed; 
  }
  else if ((key == 'a' || key == 'A')) {
    prey.velocity.x = -movementSpeed;
  }
  else if ((key == 's' || key == 'S')) {
    prey.velocity.y = movementSpeed;
  }
  else if ((key == 'd' || key == 'D')) {
    prey.velocity.x = movementSpeed;
  }
  else if ((key == 'l' || key == 'L')) {
    restart();
  }
}
