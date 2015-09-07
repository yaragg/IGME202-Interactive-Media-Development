//TRANSFORMATIONS IN-CLASS EXERCISE
//IGME 202
//Yara Grassi Gouffon

//-----------------------------------------------------------

Car c1, c2, c3;
Car c4, c5, c6;
Car c7, c8, c9, c10;

//-----------------------------------------------------------
void setup(){
  size(500, 500, P2D);
  background(180);
  c1 = new Car(500, 300);
  c2 = new Car(250, 300, color(128, 128, 128));
  c3 = new Car(200, 200, color(0.0, 255.0, 0.0));
  c4 = new Car(10, 10, color(0.0, 0.0, 255.0));
  c5 = new Car(400, 100, color(180, 180, 0));
  c6 = new Car(300, 400, color(180, 0, 180));
  c7 = new Car(400, 400, color(0, 180, 180));
  c8 = new Car(100, 400, color(40, 100, 120));
  c9 = new Car(150, 400, color(120, 100, 40));
  c10 = new Car(450, 450, color(40, 120, 100));
}

//-----------------------------------------------------------
void draw(){
  
  c1.displayTranslated(-100, 0);
  c2.displayRotated(90);
  c3.displayRotated(45);
  c4.displayScaled(2.0);
  c5.displayRotated(250);
  c6.displayTranslated(-200, -200);
  c7.displayScaled(0.5);
  c8.displayRotated(60);
  c9.displayRotated(150);
  c10.displayRotated(260);
  
}