//Vehicle class
//Specific autonomous agents will inherit from this class 
//Abstract since there is no need for an actual Vehicle object
//Implements the stuff that each auto agent needs: movement, steering force calculations, and display

abstract class Vehicle {

  //--------------------------------
  //Class fields
  //--------------------------------
  //vectors for moving a vehicle
  PVector acceleration, velocity, position;

  //no longer need direction vector - will utilize forward and right
  //these orientation vectors provide a local point of view for the vehicle
  PVector forward, right;

  //floats to describe vehicle movement and size
  float maxSpeed, maxForce, radius, mass, safeDistance;


  //--------------------------------
  //Constructor
  //Vehicle(x position, y position, radius, max speed, max force)
  //--------------------------------
  Vehicle(float x, float y, float r, float ms, float mf) {
    //Assign parameters to class fields
    position = new PVector(x, y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    right = new PVector(0, 0);
    forward = new PVector(0, 0);
    radius = r;
    maxSpeed = ms;
    maxForce = mf;
    safeDistance = 40;
    mass = 1; //Mass is needed for applyForces but the constructor we were given doesn't include it, so I'll just have everyone have the same mass for now
  }

  //--------------------------------
  //Abstract methods
  //--------------------------------
  //every sub-class Vehicle must use these functions
  abstract void calcSteeringForces();
  abstract void display();

  //--------------------------------
  //Class methods
  //--------------------------------
  
  //Method: update()
  //Purpose: Calculates the overall steering force within calcSteeringForces()
  //         Applies movement "formula" to move the position of this vehicle
  //         Zeroes-out acceleration 
  void update() {
    //calculate steering forces by calling calcSteeringForces()
    calcSteeringForces(); //<>//
    //add acceleration to velocity, limit the velocity, and add velocity to position
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    
    //calculate forward and right vectors
    forward = velocity.copy();
    forward.normalize();
    right.set(forward.y, -forward.x);
    //reset acceleration
    acceleration.set(0, 0);
  }

  
  //Method: applyForce(force vector)
  //Purpose: Divides the incoming force by the mass of this vehicle
  //         Adds the force to the acceleration vector
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }
  
  
  //--------------------------------
  //Steering Methods
  //--------------------------------
  
  //Method: seek(target's position vector)
  //Purpose: Calculates the steering force toward a target's position
  PVector seek(PVector target){
    PVector desired = PVector.sub(target, position); //<>//
    desired.normalize();
    desired.mult(maxSpeed);
    return PVector.sub(desired, velocity);

  }
  
  //Method: flee(target's position vector)
  //Purpose: Calculates the steering force toward a target's position
  PVector flee(PVector target){
    PVector desired = PVector.sub(position, target);
    desired.normalize();
    desired.mult(maxSpeed);
    return PVector.sub(desired, velocity);

  }
  
  //Method: obstacleAvoidance()
  //Purpose: Calculates the steering force to avoid the given obstacle
  PVector obstacleAvoidance(Obstacle o){
    PVector desired;
    PVector vecToC = PVector.sub(o.position, this.position);
    
    //Check for any conditions that make it unnecessary to worry about the obstacle
    //Reynold's test for non-intersection
    if(vecToC.magSq() - pow(o.radius + this.radius, 2) > pow(safeDistance, 2)) return new PVector(0, 0);
    
    //If obstacle is behind, no need to avoid it
    if(PVector.dot(vecToC, this.forward) < 0) return new PVector(0, 0); 
    
    //See if it can squeeze through
    float dotR = PVector.dot(vecToC, right);
    if(this.radius + o.radius < abs(dotR)) return new PVector(0, 0);
    
    //Can't squeeze, collision is imminent. Avoid the obstacle
    if(dotR>0) //If the target is to the right, steer to the left
      desired = PVector.mult(PVector.mult(this.right, -1), maxSpeed);
    else //Steer to the right
      desired = PVector.mult(this.right, maxSpeed);
    
    PVector steer = PVector.sub(desired, velocity); //Transform the desired velocity into a steering force
    return PVector.mult(steer, this.safeDistance/vecToC.mag()); //Scale it by distance to the obstacle
  }
}