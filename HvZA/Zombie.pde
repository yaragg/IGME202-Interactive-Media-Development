//Zombie class
//Creates an inherited Zombie object from the Vehicle class
//Due to the abstract nature of the vehicle class, the Zombie
//  must implement the following methods:  
//  calcSteeringForces() and display()

class Zombie extends Vehicle {

  //---------------------------------------
  //Class fields
  //---------------------------------------

  //seeking target
  //set to null for now
  PVector target = null;
  
  //PShape to draw this Zombie object
  PShape body;

  //overall steering force for this Zombie accumulates the steering forces
  //  of which this will be applied to the vehicle's acceleration
  PVector steeringForce;


  //---------------------------------------
  //Constructor
  //Zombie(x position, y position, radius, max speed, max force)
  //---------------------------------------
  Zombie(float x, float y, float r, float ms, float mf) {
      
    //call the super class' constructor and pass in necessary arguments
    super(x, y, r, ms, mf);

    //instantiate steeringForce vector to (0, 0)
    steeringForce = new PVector(0, 0);

    //PShape initialization
    //draw the Zombie "pointing" toward 0 degrees
    body = createShape(TRIANGLE,  0, 0, 10, -30, -10, -30);
  }


  //--------------------------------
  //Abstract class methods
  //--------------------------------
  
  //Method: calcSteeringForces()
  //Purpose: Based upon the specific steering behaviors this Zombie uses
  //         Calculates all of the resulting steering forces
  //         Applies each steering force to the acceleration
  //         Resets the steering force
  void calcSteeringForces() {  
    //get the steering force returned from calling seek
    //This Zombie's target (for now) is the mouse
    PVector seekingForce = seek(new PVector(mouseX, mouseY));
    PVector avoidanceForce = new PVector(0, 0);
    for(int i=0; i<trees.size(); i++) avoidanceForce.add(obstacleAvoidance(trees.get(i)));

    //add the above seeking force to this overall steering force
    steeringForce.add(seekingForce);
    steeringForce.add(PVector.mult(avoidanceForce, 1.5));

    //limit this Zombie's steering force to a maximum force
    steeringForce.limit(maxForce);

    //apply this steering force to the vehicle's acceleration
    applyForce(steeringForce);

    //reset the steering force to 0
    steeringForce.set(0, 0);
  }
  

  //Method: display()
  //Purpose: Finds the angle this Zombie should be heading toward
  //         Draws this Zombie as a triangle pointing toward 0 degreed
  //         All Vehicles must implement display
  void display() {
      
ellipse(position.x, position.y, radius/2, radius/2);
  }
  
  //--------------------------------
  //Class methods
  //--------------------------------
  
  
  
}