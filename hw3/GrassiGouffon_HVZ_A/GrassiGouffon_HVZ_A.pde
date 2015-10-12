ArrayList<Obstacle> trees;
ArrayList<Zombie> zombies;
ArrayList<Human> humans;
int obstacleNumber = 12;
int initialZombies = 1;
int initialHumans = 5;

//Maximum speed and force for zombies and humans
float zombieMs = 2.5, zombieMf = 0.05;
float humanMs = 3, humanMf = 0.3;

float vehicleRadius = 40; //Generic radius for humans and zombies for now

boolean debug = false;

void setup() {
  size(700, 700);

  //Initialize trees, zombies and humans
  trees = new ArrayList<Obstacle>();
  humans = new ArrayList<Human>();
  zombies = new ArrayList<Zombie>();
  
  for(int i=0; i<initialHumans; i++) humans.add(new Human(random(vehicleRadius, width-vehicleRadius), random(vehicleRadius, height-vehicleRadius), vehicleRadius, humanMs, humanMf));
  
  for(int i=0; i<initialZombies; i++) zombies.add(new Zombie(random(vehicleRadius, width-vehicleRadius), random(vehicleRadius, height-vehicleRadius), vehicleRadius, zombieMs, zombieMf));
  
  //Generate the trees while making sure they don't spawn where there is already a human or a zombie
  Obstacle o;
  for(int i=0; i<obstacleNumber; i++)
  {
    do //Keep generating a new tree until it lands on a free spot
    {
      o = new Obstacle(60*random(1, 3)); //Randomize tree position
    }
    while(isThereAnythingAt(o));
    trees.add(o);
  }
}

void draw() {
  background(255);
  
  if(debug) drawDebug();
  
  //Draw trees
  fill(#80BF6B);
  for(int i=0; i<trees.size(); i++) trees.get(i).display();
  
  //Update and draw humans
  fill(#E3CFC8);
  for(int i=0; i<humans.size(); i++)
  {
    humans.get(i).update();
    humans.get(i).display();
  }
  
  //Update and draw zombies
  fill(#789470);
  for(int i=0; i<zombies.size(); i++)
  {
    zombies.get(i).update();
    zombies.get(i).display();
  }  
  
  fill(#000000);
  textSize(16);
  text("Press 'd' for debug", 10, 20);
}

boolean isThereAnythingAt(Obstacle o)
{
  for(int i=0; i<zombies.size(); i++) //Is there a zombie at that spot?
  {
    if(zombies.get(i).hasCollided(o)) return true;
  }
  for(int i=0; i<humans.size(); i++) //Is there a human at that spot?
  {
    if(humans.get(i).hasCollided(o)) return true;
  }
  return false; //Spot is free, the tree can be added there
}

void keyPressed()
{
  if(key == 'D' || key == 'd') debug = !debug;
}

void drawDebug()
{
  for(int i=0; i<zombies.size(); i++)
  {
    Zombie z = zombies.get(i);
    //Draw target lines
    stroke(#FF0000);
    if(zombies.get(i).target != null) line(z.position.x, z.position.y, z.target.x, z.target.y);
    z.drawMovementVectors();
  }
  
  for(int i=0; i<humans.size(); i++)
  {
    humans.get(i).drawMovementVectors();
  }
  stroke(#000000);
}