class Bird
{
  float x, y;
  color c;
  float t = 0.0; //Where is it in the Perlin pattern
  float step; //How much to skip between each Perlin call 
  
  Bird(float x, float y, color c, float step)
  {
    this.x = x;
    this.y = y;
    this.c = c;
    this.step = step;
  }
  
  void display()
  {
    y = noise(t)*height;
    t += step;
    fill(c);
    ellipse(x, y, 25, 25);
  }
}