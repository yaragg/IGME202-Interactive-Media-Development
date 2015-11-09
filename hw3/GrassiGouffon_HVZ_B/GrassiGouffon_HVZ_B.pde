ArrayList<Obstacle> trees;
ArrayList<Zombie> zombies;
ArrayList<Human> humans;
int obstacleNumber = 12;
int initialZombies = 1;
int initialHumans = 5;

//Maximum speed and force for zombies and humans
float zombieMs = 2.5, zombieMf = 0.05;
float humanMs = 3, humanMf = 0.3;

float vehicleRadius = 60; //Generic radius for humans and zombies for now

boolean debug = false;

PImage zImage, hImage, tImage;

void setup() {
  size(700, 700);

  //Initialize trees, zombies and humans
  trees = new ArrayList<Obstacle>();
  humans = new ArrayList<Human>();
  zombies = new ArrayList<Zombie>();
  
  zImage = loadImage("zombie.png");
  hImage = loadImage("human.png");
  tImage = loadImage("tree.png");
  
  for(int i=0; i<initialHumans; i++) addHuman();
  
  for(int i=0; i<initialZombies; i++) addZombie();
  
  //Generate the trees while making sure they don't spawn where there is already a human or a zombie
  Obstacle o;
  for(int i=0; i<obstacleNumber; i++)
  {
    do //Keep generating a new tree until it lands on a free spot
    {
      o = new Obstacle(60*random(2, 4)); //Randomize tree position
    }
    while(isThereAnythingAt(o));
    trees.add(o);
  }
}

void draw() {
  background(#A4E069);
  
  if(debug) drawDebug();
  
  //Draw trees
  fill(#80BF6B);
  for(int i=0; i<trees.size(); i++) trees.get(i).display();
  
  //Update and draw humans
  
  for(int i=0; i<humans.size(); i++)
  {
    humans.get(i).update();
    fill(#E3CFC8);
    stroke(0);
    humans.get(i).display();
  }
  
  //Update and draw zombies
  fill(#789470);
  for(int i=0; i<zombies.size(); i++)
  {

    zombies.get(i).update();
    fill(#789470);
    stroke(0);
    zombies.get(i).display();
  }  
  
  fill(#000000);
  textSize(16);
  text("Press 'd' for debug, 'h' to add human, 'z' to add zombie", 10, 20);

}

void addHuman()
{
  humans.add(new Human(random(vehicleRadius, width-vehicleRadius), random(vehicleRadius, height-vehicleRadius), vehicleRadius, humanMs, humanMf));
}

void addZombie()
{
  zombies.add(new Zombie(random(vehicleRadius, width-vehicleRadius), random(vehicleRadius, height-vehicleRadius), vehicleRadius, zombieMs, zombieMf));
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
  if(key == 'H' || key == 'h') addHuman();
  if(key == 'Z' || key == 'z') addZombie();
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