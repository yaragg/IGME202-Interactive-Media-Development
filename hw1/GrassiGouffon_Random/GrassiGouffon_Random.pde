Bird a, b, c;
float mountainAtime = 0.0, mountainBtime = 100.0;

ArrayList<Cloud> clouds = new ArrayList<Cloud>();

void setup()
{
  size(500, 500);
  a = new Bird(200, 200, color(255, 0, 0), 0.005);
  b = new Bird(300, 100, color(0, 0, 180), 0.005);
  c = new Bird(500, 400, color(180, 0, 180), 0.005);
}

void drawBackground()
{
  drawSky();
  mountainAtime = drawMountain(0.005, 0.007, 4*height/9, 0, mountainAtime);
  fill(color(98, 222, 75));
  rect(0, height/3, width, 2*height/3);
}

void drawForeground()
{
  mountainBtime = drawMountain(0.005, 0.022, height, 3*height/9, mountainBtime);
}

void drawSky()
{
  fill(color(129, 194, 255));
  rect(0, 0, width, height/3);
}

//mt is where the mountain is relative to the Perlin noise sequence
//base and top are where is the foot of the mountain and the highest value its peaks can reach, respectively
//xstep controls the smoothness of the mountain. The lowest its value, the smoother it will be
//speed affects how fast the mountain will pass by the screen
float drawMountain(float xstep, float speed, float base, float top, float mt)
{
  float my;
  float xoff = mt;
  float max = base;
  float min = top;
  
  noStroke();
  fill(118, 156, 52);
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
  return mt; //Returns mt so it can be saved and used for the next call
}

void draw()
{
  background(180);
  drawBackground();
  a.display();
  b.display();
  c.display();
  drawForeground();
  for(int i=0; i<clouds.size(); i++) clouds.get(i).display(); //Displays all clouds
  
  if(frameCount%40==0) //Every 40 frames, decides whether to generate a new cloud
  {
    if(random(0, 1)<0.4)
    {
      //Decides what kind of cloud it will be:  
      //One that is close to the viewer (so a larger cloud that passes by quickly due to parallax), a medium one, or a small one far away that moves by slower
      float r = random(0, 1);
      if(r<0.3) //Adds to the "foreground" region - big clouds on the lower part of the screen with higher speed
        clouds.add(new Cloud (2*height/3, height, random(80, 120), 7));
      else if(r<0.6) //Adds to the middle part
        clouds.add(new Cloud (height/3, 2*height/3, random(50, 60), 3));
      else //Adds to the background far away
        clouds.add(new Cloud (0, height/3, random(25, 40), 2));
    }
  }
}