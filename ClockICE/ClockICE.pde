//IGME 202 CLOCK ICE
//WRITE THE METHODS TO ADD USER INTERACTION AND ROTATION TO THE PROGRAM
//THE BIGGER HAND SHOULD ALWAYS POINT IN THE DIRECTION OF THE MOUSE
//THE SMALLER HAND SHOULD CONTINUOUSLY ROTATE AROUND THE CLOCK

//ALL DIRECTIONS ARE IN CAPS


Hand bigHand;
Hand smallHand;
Clock clock;

void setup(){
    size(500, 500, P2D);
    background(120);    
    bigHand = new Hand();
    smallHand = new Hand();
    clock = new Clock();;
    
}

void draw(){
    background(120);
    clock.display();
    smallHand.spin();
    bigHand.followMouse();
}

void mousePressed()
{
  smallHand.arrow.rotate(1);
}