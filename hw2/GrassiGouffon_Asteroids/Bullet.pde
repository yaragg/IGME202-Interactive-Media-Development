class Bullet extends GameObject
{
  static final int maxBulletAge = 150; //How long a bullet can stay on the screen before vanishing. This allows for the bullets to wrap too, instead of destroying them when they go offscreen
  int age;
  boolean destroy = false;
  Bullet()
  {
    super(player.position.x, player.position.y, player.directionAngle, 0.5, 3);
    radius = 4;
    age = 0;
  }
  
  void checkCollisions() //Checks for collisions with asteroids
  {
    for(int i=0; i<asteroids.size(); i++)
    {
      if(isAHit(this, asteroids.get(i)))
      {
        destroy = true; //Mark bullet for destruction
        asteroids.get(i).destroy = true; //Mark asteroid for destruction
        if(!asteroids.get(i).mini) //If asteroid is big, divide in two
        {
          explosion_b.play();
          explosion_b.rewind();
          //Spawns the two smaller asteroids with a certain distance between them
          asteroids.add(new Asteroid(asteroids.get(i).position, asteroids.get(i).direction.heading(), asteroids.get(i).asteroidType));
          asteroids.add(new Asteroid(PVector.add(asteroids.get(i).position, new PVector(20, 20)), PI+asteroids.get(i).direction.heading(), asteroids.get(i).asteroidType));
        }
        else
        {
          explosion_s.play();
          explosion_s.rewind();
        }
        
      }
    }
  }
  
  void update()
  {
    direction.normalize();
    super.move();
    age++;
  }
  
  void display()
  {
    checkCollisions(); 
    //Displays the rotated bullet image
    pushMatrix();
    translate(position.x, position.y);
    rotate(direction.heading()-HALF_PI);
    image(bullet_image, 0, 0, 32, 32);
    popMatrix();
  }
}