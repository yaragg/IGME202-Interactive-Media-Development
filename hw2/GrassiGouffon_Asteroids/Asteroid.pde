class Asteroid extends GameObject
{
  Asteroid()
  {
    super(0, 0, HALF_PI, 0.03, 1);
    radius = 25;
    int side = (int) random(1, 5); //Decides which side of the screen the asteroid will come from
    //1 = top, 2 = right, 3 = bottom, 4 = left
    println(side);
    if(side == 1)
    {
      position.y = -2*radius;
      position.x = random(0, width);
    }
    else if(side == 2)
    {
      position.x = 2*radius;
      position.y = random(0, height);
    }
    else if(side == 3)
    {
      position.y = 2*radius;
      position.x = random(0, width);
    }
    else if(side == 4)
    {
      position.x = -2*radius;
      position.y = random(0, height);
    }
    println(position.x, position.y);
  } 
  
  void checkCollisions()
  {
  }
  
  void update()
  {
    direction = PVector.fromAngle(atan2(player.position.y-position.y, player.position.x-position.x));
    direction.normalize();
    super.move();
  }
  
  void display()
  {
    ellipse(position.x, position.y, 2*radius, 2*radius);
  }
  
}