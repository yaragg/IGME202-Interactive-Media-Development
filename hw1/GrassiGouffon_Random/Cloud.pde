class Cloud
{
  float x, y;
  float radius;
  PShape p;
  
  Cloud(float minpos, float maxpos, float radius)
  {
    int nParts = (int)random(2, 6);
    float lastx, lasty, curx, cury;
    p = createShape(GROUP);
    x = random(0, width+1);
    lastx = x;
    y = random(minpos, maxpos+1);
    lasty = y;
    p.addChild(createShape(ELLIPSE, x, y, radius, radius));
    for(int i = 0; i<nParts; i++)
    {
      if(random(0, 1)>0.6) curx = lastx + radius/3;
      else curx = lastx - radius/3;
      p.addChild(createShape(ELLIPSE, curx, cury, radius, radius));
    }
    p.setFill(255);
  }
  
  display()
  {
    shape(p);
  }
}