float timestep = 0.005; //How much to increase the t variable for the Perlin noise function
float xoff = 0.0;
float t = 0.0;
float ely = 0;
Bird a, b;
float mountainAtime = 0.0, mountainBtime = 100.0;
float noiseScale = 0.01;

void setup()
{
  size(500, 500);
  a = new Bird(200, 200, color(255, 0, 0), 0.005);
  b = new Bird(300, 100, color(0, 0, 180), 0.005);
}

void drawBackground()
{
  drawSky();
  mountainAtime = drawMountain(0.005, 0.01, height/3, 0, mountainAtime);
  fill(color(0, 150, 0));
  rect(0, height/3, width, 2*height/3);
}

void drawForeground()
{
  mountainBtime = drawMountain(0.005, 0.02, height, 2*height/3, mountainBtime);
}

void drawSky()
{
  //float n;
  fill(color(129, 194, 255));
  rect(0, 0, width, height/3);
  
  //for (int y = 0; y < height; y++) 
  //{
  //  for (int x = 0; x < width ; x++) 
  //  {
  //    n = noise(x*noiseScale, y*noiseScale);
  //    stroke(color(90, 50, n*255));
  //    point(x, y);
  //  }
  //}
}

float drawMountain(float xstep, float speed, float base, float top, float mt)
{
  float my;
  float xoff = mt;
  float max = base;
  float min = top;
  noStroke();
  fill(180, 180, 0);
  beginShape();
  for (int i = 0; i < width; i++) 
  {
    my = map(noise(xoff), 0, 1, min, max);
    xoff += xstep;

    vertex(i, my);
  }
  vertex(width, base);
  vertex(0, base);
  endShape();
  mt += speed;
  return mt;
}

void draw()
{
  background(180);
  //drawMountain();
  drawBackground();
  a.display();
  b.display();
  drawForeground();
}