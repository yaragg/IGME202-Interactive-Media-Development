class Bird
{
  float x, y;
  color c;
  float t = 0.0; //Where it is in the Perlin pattern
  float step; //How much to skip between each Perlin call 
  float scale = 1.0;
  float scaleInc = -0.03;
  
  Bird(float x, float y, color c, float step)
  {
    this.x = x;
    this.y = y;
    this.c = c;
    this.step = step;
    t = random(0, 255);
  }
  
  void display()
  {
    y = noise(t)*height;
    x = noise(t+10)*width;
    t += step;
    fill(c);
    //ellipse(x, y, 25, 25);
    image(body, x, y, 0.66*body.width, 0.66*body.height);
    pushMatrix();
    //translate(x, y);
    scale(1, scale);
    image(wing, x+0.5*body.width/2, y-0.92*wing.height/2, 0.66*wing.width, 0.66*wing.height);
    popMatrix();
    scale += scaleInc;
    if(scale<=-1.0 ) scaleInc = 0.03;
    else if(scale>=1.0) scaleInc = -0.03;
  }
}