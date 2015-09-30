boolean boxMode = false;
CollisionDetector cursor;
ArrayList<? extends CollisionDetector> objects;
ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Box> boxes = new ArrayList<Box>();
Circle cursorCircle;
Box cursorBox;

void setup()
{
  size(600, 600, P2D);
  background(180);
  cursorCircle = new Circle(5, 5, 10);
  cursorBox = new Box(5, 5, 10, 15);
  circles.add(new Circle(100, 100, 20));
  circles.add(new Circle(250, 300, 30));
  circles.add(new Circle(400, 150, 10));
  boxes.add(new Box(100, 100, 20, 30));
  boxes.add(new Box(250, 300, 30, 20));
  boxes.add(new Box(400, 150, 10, 20));
  objects = circles;
  cursor = cursorCircle;
}

void draw()
{
  background(180);
  text("Press s to switch modes.", 10, 20);
  cursorCircle.p.setFill(#DDFFDD);
  cursorBox.p.setFill(#DDFFDD);
  for(int i=0; i<objects.size(); i++) objects.get(i).display();
  cursor.setPosition(mouseX, mouseY);
  cursor.display();
}

void keyPressed()
{
  if(key == 's' || key == 'S') switchMode();
}

void switchMode()
{
  boxMode = !boxMode;
  if(boxMode)
  {
    objects = boxes;
    cursor = cursorBox;
  }
  else
  {
    objects = circles;
    cursor = cursorCircle;
  }
}