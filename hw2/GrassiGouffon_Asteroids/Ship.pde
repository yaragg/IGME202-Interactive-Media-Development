class Ship extends GameObject
{
  float directionAngle = -HALF_PI;
  PImage ship_thrusters, ship_normal, active_image;
  Ship()
  {
    super(width/2, height/2, -HALF_PI, 0, 5);
    radius = 10;
    ship_normal = loadImage("ship_no_thrusters.png");
    ship_thrusters = loadImage("ship_with_thrusters.png");
    active_image = ship_normal;
  }
  
  void checkCollisions()
  {
    for(int i=0; i<asteroids.size(); i++)
    {
      if(isAHit(this, asteroids.get(i)))
      {
        fill(#FF0000);
        playing = false;
      }
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
    pushMatrix();
    translate(position.x, position.y);
    rotate(directionAngle+HALF_PI);
    //rect(position.x, position.y, 10, 20);
    //rect(0, 0, 2*radius, 2*radius);
    image(active_image, 0, 0, 32, 32);
    popMatrix();
    fill(#FFFFFF);
  }
  
  void fire()
  {
    if(bullets.size()<maxBulletsOnScreen)
      bullets.add(new Bullet());
  }
}