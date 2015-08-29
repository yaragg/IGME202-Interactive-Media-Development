LightSwitch ls;

void setup()
{
  size(600, 600);
  ls = new LightSwitch(400, 450);
}

void draw()
{
  ls.display();
}

void mouseClicked()
{
  if(mouseX>=ls.getX() && mouseX<=ls.getX()+ls.getWidth() && mouseY>=ls.getY() && mouseY<=ls.getY()+ls.getHeight())
    ls.flip();
    
}