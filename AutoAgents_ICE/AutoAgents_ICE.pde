
//Beginning to code autonomous agents
//Will implement inheritance with a Vehicle class and a Seeker class

ArrayList<Obstacle> obstacles;
Seeker s;
int obstacleNumber = 12;

void setup() {
  size(1000, 1000);
  s = new Seeker(width/2, height/2, 6, 4, 0.1);
  obstacles = new ArrayList<Obstacle>();
  
  for(int i=0; i<obstacleNumber; i++) obstacles.add(new Obstacle(80*random(1, 4)));
}

void draw() {
  background(255);
  
  // Draw an ellipse at the mouse location
  ellipse(mouseX, mouseY, 20, 20);
  //shape(s.body,  mouseX, mouseY);
  //update the seeker - done for you
  for(int i=0; i<obstacles.size(); i++) obstacles.get(i).display();
  s.update();
  s.display();
  
}