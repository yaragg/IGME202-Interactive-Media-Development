class Circle implements CollisionDetector
{
  float x, y, radius;
  PShape p;
  
  Circle(float x, float y, float radius)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    p = createShape(ELLIPSE, x, y, radius, radius);
  }
  
  boolean isAHit(Circle circle)
  {
    if(pow(circle.x - this.x, 2) + pow(circle.y - this.y, 2) <= pow(circle.radius + this.radius, 2))
      return true;
    else return false;
  }
  
  boolean isAHit(CollisionDetector c)
  {
    return isAHit((Circle) c);
    //Could have it check for Boxes and use another function for that too, but it's not part of the exercise
  }
  
  void display()
  {
    shape(p);
  }
  
  void setPosition(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
}