//Asteroids, Bullets and Ships all inherit this class. This allows me to use a single collision detection method for all three, as well as centralize vector movement
abstract class GameObject
{
  PVector position, velocity, acceleration, direction;
  float accelRate, maxSpeed, radius;
  abstract void checkCollisions();
  abstract void update();
  abstract void display();
  
  GameObject(float x, float y, float dir, float a, float ms) //Generic constructor for the subclasses to use
  {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    direction = PVector.fromAngle(dir);
    acceleration = new PVector(0, 0);
    accelRate = a;
    maxSpeed = ms;
  }
  
  boolean isAHit(GameObject a, GameObject b) //Uses bounding circles to check if two elements have collided
  {
    if(pow(a.position.x - b.position.x, 2) + pow(a.position.y - b.position.y, 2) <= pow(a.radius + b.radius, 2))
        return true;
    else return false;
  }
  
  void move()
  {
    //Direction should be set by the subclass before calling this method
    acceleration = PVector.mult(direction, accelRate);
    velocity.add(acceleration);
    if(this instanceof Ship) velocity.mult(0.99); //Adds drag to player ship. Drag in vacuum? My Physics professor must be feeling sick now...
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.set(0, 0);
    wrapScreen();
  }
  
  void wrapScreen() //Checks if object is at the edge of the screen and wraps
  {
    if(position.x>width) position.x = 0;
    else if(position.x<0) position.x = width;
    if(position.y>height) position.y = 0;
    else if(position.y<0) position.y = height;
  }

}