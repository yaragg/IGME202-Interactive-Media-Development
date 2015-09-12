class Cloud
{
  float x, y;
  float radius;
  PShape p;
  
  Cloud(float minpos, float maxpos, float radius)
  {
    int nParts = (int)random(13, 25);
    float lastx, lasty, curx, cury;
    noStroke();
    p = createShape(GROUP);
    x = random(0, width+1);
    lastx = x;
    y = random(minpos, maxpos+1);
    lasty = y;
    cury = y;
    p.addChild(createShape(ELLIPSE, x, y, radius, radius));
    p.getChild(0).setFill(color(255, 255, 255, 60));
    for(int i = 1; i<=nParts; i++)
    {
      if(random(0, 1)>0.6) curx = lastx + random(radius/3, 7*radius/10);
      else curx = lastx - random(radius/3, 7*radius/10);
      if(random(0, 1)>0.5) cury = lasty + random(0, radius/3);
      else cury = lasty - random(0, radius/3);
      p.addChild(createShape(ELLIPSE, curx, cury, radius, radius));
      p.getChild(i).setFill(color(255, 255, 255, 60));
    }
    //p.setFill(255);
    //p.setTint(50);
  }
  
  void display()
  {
    //filter(BLUR, 6);
    shape(p);
    //filter(0);
  }
}