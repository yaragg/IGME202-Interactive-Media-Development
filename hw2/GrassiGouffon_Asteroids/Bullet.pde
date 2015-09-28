class Bullet extends GameObject
{
  static final int maxBulletAge = 150;
  int age;
  boolean destroy = false;
  Bullet()
  {
    super(player.position.x, player.position.y, player.directionAngle, 0.5, 3);
    radius = 4;
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
        if(!asteroids.get(i).mini)
        {
          asteroids.add(new Asteroid(asteroids.get(i).position, asteroids.get(i).direction.heading(), asteroids.get(i).asteroidType));
          asteroids.add(new Asteroid(PVector.add(asteroids.get(i).position, new PVector(20, 20)), PI+asteroids.get(i).direction.heading(), asteroids.get(i).asteroidType));
        }
        
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
    //rect(position.x, position.y, 2*radius, 2*radius);
    pushMatrix();
    translate(position.x, position.y);
    rotate(direction.heading()-HALF_PI);
    image(bullet_image, 0, 0, 32, 32);
    popMatrix();
    fill(#FFFFFF);
  }
}