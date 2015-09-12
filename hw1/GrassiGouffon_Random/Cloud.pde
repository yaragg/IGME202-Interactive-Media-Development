class Cloud
{
  float x, y;
  float radius;
  float speed;
  float age = 0, maxAge;
  PShape p;
  
  //Generates a cloud to the right of the screen, with its y position randomly defined between minpos and maxpos.
  //The speed refers to how fast it will cross the screen, so as to allow parallax
  Cloud(float minpos, float maxpos, float radius, float speed)
  {
    int nParts = (int)random(17, 30); //How many parts will this cloud have?
    //Lastx and lasty are the (x,y) values of the latest cloud part that was created
    //Curx and cury are the new cloud part's current (x,y) values
    float lastx, lasty, curx, cury;
    this.speed = speed;
    //Estimates how long the cloud will need to cross the screen and disappear, after which it can be destroyed
    this.maxAge = width/speed+30;
    
    //Creates the cloud shape
    noStroke();
    p = createShape(GROUP);
    x = width+100;
    lastx = x;
    y = random(minpos, maxpos+1);
    lasty = y;
    cury = y;
    
    //Generates the first part of the cloud
    p.addChild(createShape(ELLIPSE, x, y, radius, radius));
    p.getChild(0).setFill(color(255, 255, 255, 60));
    
    //Generates the rest of the cloud
    for(int i = 1; i<=nParts; i++)
    {
      //Uses a directed random algorithm to pick a x and y offset for each new part, relative to the last created part.
      //This matters because it favors the cloud "expanding" rather than going back and making itself more compact but thicker
      if(random(0, 1)>0.6) curx = lastx + random(radius/4, radius/2);
      else curx = lastx - random(radius/4, radius/2);
      if(random(0, 1)>0.5) cury = lasty + random(0, radius/2);
      else cury = lasty - random(0, radius/2);
      p.addChild(createShape(ELLIPSE, curx, cury, radius, radius));
      p.getChild(i).setFill(color(255, 255, 255, 60));
      lastx = curx;
      lasty = cury;
    }
  }
  
  void display()
  {
    p.translate(-speed, 0);
    shape(p);
    age++;
    //Kill the cloud if it's old enough so as to free up memory
    //(Assuming by then the cloud will already have disappeared from the screen)
    if(age>=maxAge) clouds.remove(clouds.indexOf(this));
   
  }
}