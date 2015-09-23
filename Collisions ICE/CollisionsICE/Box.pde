class Box implements CollisionDetector
{
  float x, y, w, h;
  PShape p;
  
  
  Box(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    p = createShape(RECT, 0, 0, w, h);
  }
  
  boolean isAHit(Box box)
  {
    if(box.x < this.x+this.w && box.x+box.w > this.x && box.y < this.y+this.h && box.y+box.h > this.y)
        return true;
    else return false;
  }
  
  boolean isAHit(CollisionDetector c)
  {
    return isAHit((Box) c);
    //Could have it check for Circles and use another function for that too, but it's not part of the exercise
  }
  
  void display()
  {
    if(this != cursor)
    {
      if(isAHit(cursor)) cursorBox.p.setFill(#0000FF);
    }
    shape(p, x, y);
  }
  
  void setPosition(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
}