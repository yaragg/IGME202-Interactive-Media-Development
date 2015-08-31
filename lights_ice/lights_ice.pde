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
  if(ls.wasClicked())
    ls.flip();
    
}