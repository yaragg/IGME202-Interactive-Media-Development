class LightSwitch
{
  private int x, y;
  private int w=50, h=30;
  private boolean on=true;
  
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
}