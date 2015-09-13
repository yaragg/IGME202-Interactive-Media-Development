class Bird
{
  float x, y;
  float prevy, prevx;
  color c;
  float t = 0.0; //Where it is in the Perlin pattern
  float step; //How much to skip between each Perlin call 
  float scale = random(-2, 2); //How much to scale the wings by, for their animation. Randomized at start so the birds won't be flapping at the same time
  float scaleInc = -0.04; //Controls the wing "movement" by increasing or decreasing the scale
  float rotation = 0.0; //Current angle of the bird image
  float rotateInc = radians(5); //Works just like scaleInc but affects rotation
  float angle = 0.0; //Direction the bird is flying to
  
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

    //Let's draw the bird!
    pushMatrix();
    
    //Part one: the body
    translate(x,y); 
    angle = atan2(y-prevy, x-prevx); //Figures out the angle the bird is going to fly to now
    
    if(angle>rotation) rotateInc = 0.01; //If it's bigger than the angle the bird is being displayed at, we'll increase the display angle (rotation)
    else if(angle<rotation) rotateInc = -0.01; //We'll decrease it if the new angle is smaller
    rotation += rotateInc;
    if(rotation>=0.9) rotation= 0.9; //Keeps the angle from getting too big so the bird won't look like it's flying 90 degrees to the ground
    else if(rotation<=-0.9) rotation = -0.9;
    rotate(rotation);
    image(body, 0, 0, 0.66*body.width, 0.66*body.height);
    
    //Part two: the wings
    translate(0.47*body.width/2, 0.4*wing.height/2); //Have to translate a bit more to place the wings at the right place relative to the body
    scale(1, scale); //Scales them to create the flapping animation
    image(wing, 0, 0, 0.66*wing.width, 0.66*wing.height);
    popMatrix();
    
    //Increases or decreases the scaling factor as part of the animation
    scale += scaleInc;
    if(scale<=-1.0 ) scaleInc = 0.04;
    else if(scale>=1.0) scaleInc = -0.04;
  }
}