class Obstacle
{
  PVector position;
  float radius;
  
  Obstacle(float radius)
  {
    //Choose position randomly
    float x = random(0, width+1);
    float y = random(0, height+1);
    this.radius = radius;
    position = new PVector(x, y);
  }
  
  void display()
  {
    ellipse(position.x, position.y, radius/2, radius/2);
  }
  
}