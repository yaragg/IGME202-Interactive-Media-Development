abstract class GameObject
{
  PVector position, velocity, acceleration, direction;
  float accelRate, maxSpeed;
  abstract void checkCollisions();
  abstract void update();
  abstract void display();
  
  GameObject(float x, float y, float dir, float a, float ms)
  {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    direction = PVector.fromAngle(dir);
    acceleration = new PVector(0, 0);
    accelRate = a;
    maxSpeed = ms;
  }
  
  boolean isAHit() //Uses bounding circles to check if two elements have collided
  {
    return false;
  }
  
  void move()
  {
    //set direction
    acceleration = PVector.mult(direction, accelRate);
    velocity.add(acceleration);
    velocity.mult(0.99);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.set(0, 0);
  }

}