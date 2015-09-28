class Asteroid extends GameObject
{
  boolean destroy = false; //Lets the game know whether to destroy this asteroid
  boolean entering = true; //Just spawned offscreen, need to ignore the screen wrapping so it doesn't just pop up in the screen
  boolean mini = false; //Has it already broken into smaller asteroids?
  int asteroidType; //Which of the four asteroid images should be used
  Asteroid()
  {
    super(0, 0, HALF_PI, 0.03, 1);
    radius = 25;
    int side = (int) random(1, 5); //Decides which side of the screen the asteroid will come from
    
    //1 = top, 2 = right, 3 = bottom, 4 = left    
    if(side == 1) //Sets the asteroid to appear offscreen from the chosen side, and randomly selects the remaining coordinate
    {
      position.y = -2*radius;
      position.x = random(0, width);
    }
    else if(side == 2)
    {
      position.x = width + 2*radius;
      position.y = random(0, height);
    }
    else if(side == 3)
    {
      position.y = height + 2*radius;
      position.x = random(0, width);
    }
    else if(side == 4)
    {
      position.x = -2*radius;
      position.y = random(0, height);
    }
    
    asteroidType = (int) random(0, 4);
  } 
  
  //Constructor for the smaller asteroids
  //start is where the starting position, directionAngle is where it should head, and type is the asteroid type image
  Asteroid(PVector start, float directionAngle, int type)
  {
    super(start.x, start.y, directionAngle, 0.03, 1);
    radius = 10;
    entering = false;
    mini = true;
    asteroidType = type;
  }
  
  void wrapScreen()
  {
    if(!entering) super.wrapScreen();
  }
  
  void checkCollisions() //Shouldn't be called since the Bullet and Ship classes handle checking
  {
  }
  
  void update()
  {
    direction = PVector.fromAngle(atan2(player.position.y-position.y, player.position.x-position.x)); //Head towards player
    direction.normalize();
    super.move();
    if(position.x >= 0 && position.x < width && position.y >= 0 && position.y < height) entering = false; //Checks to see if the asteroid is already inside screen
  }
  
  void display()
  {
    //Displays the proper asteroid image
    image(asteroid_images[asteroidType][int(mini)], position.x, position.y, asteroid_images[asteroidType][int(mini)].width, asteroid_images[asteroidType][int(mini)].height);
  }
  
}