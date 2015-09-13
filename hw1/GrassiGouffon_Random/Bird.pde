class Bird
{
  float x, y;
  float prevy, prevx;
  color c;
  float t = 0.0; //Where it is in the Perlin pattern
  float step; //How much to skip between each Perlin call 
  float scale = random(-2, 2);
  //float scale = 1.0;
  float scaleInc = -0.04;
  float rotation = 0.0;
  float rotateInc = radians(5);
  float angle = 0.0;
  
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
    prevy = y;
    prevx = x;
    y = noise(t)*height;
    x = noise(t+10)*width;
    t += step;
    fill(c);

    pushMatrix();
    translate(x,y); 
    angle = atan2(y-prevy, x-prevx);
    if(angle>rotation) rotateInc = 0.01;
    else if(angle<rotation) rotateInc = -0.01;
    rotation += rotateInc;
    if(rotation>=0.9) rotation= 0.9;
    else if(rotation<=-0.9) rotation = -0.9;
    rotate(rotation);
    image(body, 0, 0, 0.66*body.width, 0.66*body.height);
    
    translate(0.47*body.width/2, 0.4*wing.height/2);

    scale(1, scale);
    image(wing, 0, 0, 0.66*wing.width, 0.66*wing.height);
    popMatrix();
    scale += scaleInc;
    if(scale<=-1.0 ) scaleInc = 0.04;
    else if(scale>=1.0) scaleInc = -0.04;
  }
}