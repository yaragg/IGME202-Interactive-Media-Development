
//Beginning to code autonomous agents
//Will implement inheritance with a Vehicle class and a Seeker class


Seeker s;

void setup() {
  size(1000, 1000);
  s = new Seeker(width/2, height/2, 6, 4, 0.1);
}

void draw() {
  background(255);
  
  // Draw an ellipse at the mouse location
  ellipse(mouseX, mouseY, 20, 20);
  //shape(s.body,  mouseX, mouseY);
  //update the seeker - done for you
  s.update();
  s.display();
  
}