class LightSwitch
{
  private int x, y;
  private int w=40, h=20;
  private boolean on=true;
  
  LightSwitch(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  void display()
  {
    fill(255, 176, 52);
    rect(x-5, y-5, w+10, h+10);
    fill(232, 87, 50);
    rect(x, y, w, h);
  }
  
  boolean wasClicked()
  {
    if(mouseX>=x && mouseX<=x+w && mouseY>=y && mouseY<=y+h)
      return true;
    else return false;
  }
   
  void flip()
  {
    on = !on;
    if(on) background(200);
    else background(50);
  }
  
  boolean isOn()
  {
    return on;
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
}