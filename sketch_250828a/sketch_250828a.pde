long currentTime;
long previousTime;
long deltaTime;
long pT = 0;


Prey prey;
Predator[] predators;

int predatorAmount;
float movementSpeed = 4.5;
boolean won = false;
boolean lost = false;
boolean doOnce = true;

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
  
  won = false;
  lost = false;
  doOnce = true;
  
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
    if (predators[i].location.x < prey.location.x + prey.diameter / 2
    && predators[i].location.x > prey.location.x - prey.diameter / 2
    && predators[i].location.y < prey.location.y + prey.diameter / 2
    && predators[i].location.y > prey.location.y - prey.diameter / 2) {
      
       prey.death();
       lost = true;
    } else if (predators[i].location.x + predators[i].FOV < prey.location.x + prey.diameter / 2
    && predators[i].location.x - predators[i].FOV > prey.location.x - prey.diameter / 2
    && predators[i].location.y + predators[i].FOV < prey.location.y + prey.diameter / 2
    && predators[i].location.y - predators[i].FOV > prey.location.y - prey.diameter / 2) {
      
      predators[i].predatorState = State.CHASING;
      predators[i].seekPlayer(prey.location);
    }
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
  
  if (!won && !lost && prey.location.x > 700) {
    println("You win!");
    won = true;
  }
  
  if (lost) {
     long cT = millis();
     
     if (doOnce) {
        pT = cT;
        doOnce = false;
     }
     
     if ((cT - pT) > 2000) {
        println("You lost.");
        restart(); 
     }
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
