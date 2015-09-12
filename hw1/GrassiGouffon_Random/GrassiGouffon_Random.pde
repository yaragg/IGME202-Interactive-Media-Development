float timestep = 0.005; //How much to increase the t variable for the Perlin noise function
float xoff = 0.0;
float t = 0.0;
float ely = 0;

void setup()
{
  size(500, 500);
  
  
}

void draw()
{
  background(180);
  int i;
  stroke(color(0, 180, 0));
  ellipse(width/2, ely, 20, 20);
  //for(i=0; i<height; i++)
  //{
  //  //line(i, height, i, map(noise(xoff), 0, 1, height/2, height));
  //  if(i == width/2) ely = noise(xoff)*height;
    
  //}
  ely = noise(xoff)*height;
  xoff += timestep;
}