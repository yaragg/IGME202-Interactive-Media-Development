class Ship extends GameObject
{
  float directionAngle = HALF_PI;
  Ship()
  {
    //super(width/2, height/2, HALF_PI, 3, 5);
    super(width/2, height/2, HALF_PI, 0, 5);
    radius = 10;
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
    rect(0, 0, 2*radius, 2*radius);
    popMatrix();
    fill(#FFFFFF);
  }
  
  void fire()
  {
    if(bullets.size()<maxBulletsOnScreen)
      bullets.add(new Bullet());
  }
}