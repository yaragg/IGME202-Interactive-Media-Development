//Lights on, Lights off ICE
//By Yara Grassi Gouffon

LightSwitch ls;

void setup()
{
  size(600, 600);
  ls = new LightSwitch(400, 450);
}

void draw()
{
  drawBg();
  drawClock();
  ls.display();
}

void mouseClicked()
{
  if(ls.wasClicked())
    ls.flip();
    
}

/******** DRAWING FUNCTIONS **********/
//It felt like a waste to create separate classes just for drawing Moon, Cloud and such, so I left them here

void drawClock() //Draws the clock control remote thing, minus the light switch itself
{
  fill(219, 155, 255);
  rect(ls.getX()-10, ls.getY()-65, 60, 100);
  fill(0);
  ellipse(ls.getX()+20, ls.getY()-35, 50, 50);
  fill(255);
  ellipse(ls.getX()+20, ls.getY()-35, 45, 45);
  fill(0);
  rect(ls.getX()+18, ls.getY()-53, 2, 18);
  rect(ls.getX()+20, ls.getY()-35, 11, 2);
}

void drawBg()
{
  noStroke();
  fill(137, 184, 255);
  rect(0, 0, width, height/2);
  fill(27, 255, 28);
  rect(0, height/2, width, height/2);
  fill(23, 133, 33);
  ellipse(50, 500, 5, 5);
  ellipse(500, 520, 5, 5);
  ellipse(300, 400, 5, 5);
  ellipse(100, 320, 5, 5);
  ellipse(150, 560, 5, 5);
  if(ls.isOn()) drawDayBg(); 
  else drawNightBg();
  stroke(0);
}

void drawDayBg()
{
  drawCloud(50, 50, 30);
  drawCloud(150, 100, 20);
  drawCloud(180, 180, 30);
  drawCloud(400, 70, 30);
  drawCloud(500, 150, 40);
  drawSun();
}

void drawNightBg()
{
  fill(0, 0, 0, 150);
  rect(0, 0, width, height);
  fill(255);
  ellipse(50, 50, 5, 5);
  ellipse(150, 100, 5, 5);
  ellipse(180, 180, 5, 5);
  ellipse(400, 70, 5, 5);
  ellipse(500, 150, 5, 5);
  ellipse(100, 240, 5, 5);
  drawMoon();
}

void drawSun()
{
  noStroke();
  fill(255, 229, 27);
  ellipse(width/2, 100, 50, 50);
}

void drawMoon()
{
  noStroke();
  fill(255);
  ellipse(width/2, 100, 50, 50);
  fill(137, 184, 255);
  ellipse(width/2+10, 100, 45, 45);
  fill(0, 0, 0, 150);
  ellipse(width/2+10, 100, 45, 45);
}

void drawCloud(int x, int y, int size)
{
  fill(255);
  ellipse(x, y, size, size);
  ellipse(x+2*size/3, y, size, size);
  ellipse(x+2*size/3, y+2*size/3, size, size);
  ellipse(x, y+2*size/3, size, size);
}