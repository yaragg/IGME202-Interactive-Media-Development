
ArrayList<Obstacle> trees;
ArrayList<Zombie> zombies;
ArrayList<Human> humans;
//Zombie s;
int obstacleNumber = 12;

void setup() {
  size(1000, 1000);
  //s = new Zombie(width/2, height/2, 6, 4, 0.1);
  trees = new ArrayList<Obstacle>();
  humans = new ArrayList<Human>();
  zombies = new ArrayList<Zombie>();
  
  for(int i=0; i<3; i++) humans.add(new Human(width/5, height/2, 20, 4, 0.1));
  
  for(int i=0; i<3; i++) zombies.add(new Zombie(100, 1000, 20, 4, 0.1));
  
  
  for(int i=0; i<obstacleNumber; i++) trees.add(new Obstacle(80*random(1, 4)));
}

void draw() {
  background(255);
  
  // Draw an ellipse at the mouse location
  //ellipse(mouseX, mouseY, 20, 20);
  //shape(s.body,  mouseX, mouseY);
  //update the Zombie - done for you
  fill(#80BF6B);
  for(int i=0; i<trees.size(); i++) trees.get(i).display();
  fill(#FFFFFF);
  
  fill(#E3CFC8);
  for(int i=0; i<humans.size(); i++)
  {
    humans.get(i).update();
    humans.get(i).display();
  }
  
  fill(#789470);
  for(int i=0; i<zombies.size(); i++)
  {
    zombies.get(i).update();
    zombies.get(i).display();
  }
  
  
  //s.update();
  //s.display();
  
}