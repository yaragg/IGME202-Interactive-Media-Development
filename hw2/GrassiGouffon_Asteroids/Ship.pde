class Ship extends GameObject
{
  float directionAngle = -HALF_PI;
  PImage ship_thrusters, ship_normal, active_image; //active_image means which image should be displayed
  Ship()
  {
    super(width/2, height/2, -HALF_PI, 0, 5); //I would use directionAngle instead of -HALF_PI but it doesn't allow instance variables when calling the constructor
    radius = 10;
    ship_normal = loadImage("ship_no_thrusters.png");
    ship_thrusters = loadImage("ship_with_thrusters.png");
    active_image = ship_normal;
  }
  
  void checkCollisions() //Checks for collision with asteroids
  {
    for(int i=0; i<asteroids.size(); i++)
    {
      if(isAHit(this, asteroids.get(i)))
        playing = false;
    }
  }
  
  void update()
  {
    direction = PVector.fromAngle(directionAngle);
    direction.normalize();
    super.move();
  }
  
  void display()
  {
    checkCollisions();
    pushMatrix(); //Rotate ship and display
    translate(position.x, position.y);
    rotate(directionAngle+HALF_PI);
    image(active_image, 0, 0, 32, 32);
    popMatrix();
  }
  
  void fire()
  {
    if(bullets.size()<maxBulletsOnScreen) //Only allow player to shoot if the maximum number of bullets on screen hasn't been exceeded
      bullets.add(new Bullet());
  }
}