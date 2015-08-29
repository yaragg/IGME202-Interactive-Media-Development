class LightSwitch
{
  int x, y;
  int w=50, h=30;
  boolean on=true;
  
  LightSwitch(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  void display()
  {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }
  
  int getX()
  {
    return x;
  }
  
  int getY()
  {
    return y;
  }
  
  int getWidth()
  {
    return w;
  }
  
  int getHeight()
  {
    return h;
  }
  
  void flip()
  {
    on = !on;
    if(on) background(200);
    else background(50);
  }
}