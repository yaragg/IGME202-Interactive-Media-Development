class Ship extends GameObject
{
  float directionAngle = HALF_PI;
  Ship()
  {
    //super(width/2, height/2, HALF_PI, 3, 5);
    super(width/2, 0, HALF_PI, 0, 7);
  }
  
  void checkCollisions()
  {
  }
  
  void update()
  {
    //direction = PVector.fromAngle(directionAngle);
    direction.normalize();
    super.move();
  }
  
  void display()
  {
    rect(position.x, position.y, 10, 20);
  }
}