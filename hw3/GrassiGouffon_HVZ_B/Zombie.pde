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
    PVector seekingForce = new PVector(0, 0);
    PVector avoidanceForce = new PVector(0, 0);
    
    //Find closest human and seek it
    target = null;
    if(humans.size()>0) 
    {
      Human human = humans.get(0);
      for(int i=1; i<humans.size(); i++)
      {
        if(PVector.sub(humans.get(i).position, this.position).magSq() < PVector.sub(human.position, this.position).magSq()) //There is a closer human
          human = humans.get(i);
      }
      target = human.position;
      seekingForce = pursue(human);
    }
    
    //Avoid obstacles
    for(int i=0; i<trees.size(); i++) avoidanceForce.add(avoid(trees.get(i)));
    
    //Stay within boundaries
    PVector boundaryForce = stayWithinBoundaries();

    //add the above seeking force to this overall steering force
    steeringForce.add(PVector.mult(seekingForce, 1.4));
    //steeringForce.add(PVector.mult(avoidanceForce, 1.5));
    steeringForce.add(avoidanceForce);
    steeringForce.add(PVector.mult(boundaryForce, 2));

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
  
  void update() //Uses the Vehicle's update method, but also needs to check for collision with humans
  {
    super.update();
    
    //Checks for collision
    for(int i=0; i<humans.size(); i++)
    {
      if(hasCollided(humans.get(i))) //Remove human and spawn a zombie at the same location
      {
        zombies.add(new Zombie(humans.get(i).position.x, humans.get(i).position.y, vehicleRadius, zombieMs, zombieMf));
        humans.remove(i);
      }
    }
  }
  
}