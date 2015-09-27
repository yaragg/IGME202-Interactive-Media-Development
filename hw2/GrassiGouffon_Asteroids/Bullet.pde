class Bullet extends GameObject
{
  static final int maxBulletAge = 150;
  int age;
  boolean destroy = false;
  Bullet()
  {
    super(player.position.x, player.position.y, player.directionAngle, 0.5, 3);
    radius = 3;
    age = 0;
  }
  
  void checkCollisions()
  {
    for(int i=0; i<asteroids.size(); i++)
    {
      if(isAHit(this, asteroids.get(i)))
      {
        fill(#0000FF);
        destroy = true;
        asteroids.get(i).destroy = true;
      }
    }
  }
  
  void update()
  {
    //direction = PVector.fromAngle(directionAngle);
    direction.normalize();
    super.move();
    age++;
  }
  
  void display()
  {
    checkCollisions();
    rect(position.x, position.y, 2*radius, 2*radius);
    fill(#FFFFFF);
  }
}