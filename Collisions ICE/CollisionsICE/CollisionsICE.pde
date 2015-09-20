boolean boxMode = false;
CollisionDetector cursor = new Circle(mouseX, mouseY, 5);
ArrayList<CollisionDetector> objects = new ArrayList<CollisionDetector>();

void setup()
{
  size(600, 600, P2D);
  background(180);
  objects.add(new Circle(100, 100, 10));
}

void draw()
{
  for(int i=0; i<objects.size(); i++) objects.get(i).display();
  cursor.setPosition(mouseX, mouseY);
  cursor.display();
}