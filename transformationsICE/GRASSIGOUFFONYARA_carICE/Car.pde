
//TRANSFORMATIONS IN-CLASS EXERCISE
//IGME 202

//-----------------------------------------------------------
// CAR CLASS
class Car {

  int xCoord;
  int yCoord;
  PShape car;
  
  Car(int x, int y, color c) {
    xCoord = x;
    yCoord = y;

    //Creates rectangular body shape of the car
    //I tried to come up with something prettier but I couldn't for the life of me figure out how to work with Inkscape :(
    car = createShape(GROUP);
    PShape body = createShape();
    body.beginShape();
    body.vertex(x, y);
    body.vertex(x+20, y);
    body.vertex(x+20, y+40);
    body.vertex(x, y+40);
    body.endShape(CLOSE);

    // Adds black wheels
    car.addChild(createShape(ELLIPSE, x, y+2, 5, 10));
    car.getChild(0).setFill(color(0.0, 0.0, 0.0));
    car.addChild(createShape(ELLIPSE, x+20, y+2, 5, 10));
    car.getChild(1).setFill(color(0.0, 0.0, 0.0));
    car.addChild(createShape(ELLIPSE, x+20, y+38, 5, 10));
    car.getChild(2).setFill(color(0.0, 0.0, 0.0));
    car.addChild(createShape(ELLIPSE, x, y+38, 5, 10));
    car.getChild(3).setFill(color(0.0, 0.0, 0.0));  
    
    //Sets the color for the body
    body.setFill(c);
    car.addChild(body);
  }
  
   Car(int x, int y) { //If no color is given, assume red as default
    this(x, y, color(255.0, 0.0, 0.0));
  }

  // DISPLAYTRANSLATED WILL DRAW A TRANSLATED CAR TO THE WINDOW
  // **THIS CODE IS ALREADY DONE FOR YOU**
  void displayTranslated(int x, int y) {
    pushMatrix();
    translate(x, y);
    shape(car);
    popMatrix();
  }

  // DISPLAYROTATED WILL DRAW A ROTATED CAR TO THE WINDOW
  // APPLY ROTATIONS HERE AND COMPLETE THE FUNCTION BELOW
  void displayRotated(float angleInDegrees) {
    pushMatrix();
    translate(xCoord+10, yCoord+20);    //Had to add half the width and height of the car so it would rotate around its center and not around the top left corner
    rotate(radians(angleInDegrees));
    shape(car, -xCoord-10, -yCoord-20);
    popMatrix();
  }

  // DISPLAYSCALED WILL DRAW THIS CAR TO THE WINDOW
  // APPLY SCALING HERE AND COMPLETE THE FUNCTION BELOW
  void displayScaled(float scaleFactor) {
    pushMatrix();
    translate(xCoord, yCoord);
    scale(scaleFactor);
    shape(car, -xCoord, -yCoord);
    popMatrix();
  }
}