Ship player;
int turning = 0; //0 = not turning, 1 = left, 2 = right
boolean accelerating = false;
void setup()
{
  size(600, 600);
  player = new Ship();
}

void draw()
{
  background(180);
  
  //if(keyPressed && turning == 1) player.directionAngle += 1;
  //else if(keyPressed && turning == 2) player.directionAngle -= 1;
  
  //if(keyPressed && keyCode == LEFT) player.direction.rotate(0.1);
  //else if(keyPressed && keyCode == RIGHT) player.direction.rotate(-0.1);
  ////player.accelRate = 0.1;
  //if(keyPressed && keyCode == UP) player.accelRate = 0.5;
  //else player.accelRate = 0.2;
  //else player.accelRate = 0;
  
  if(turning == 1) player.direction.rotate(0.1);
  else if(turning == 2) player.direction.rotate(-0.1);
  //player.accelRate = 0.1;
  if(accelerating) player.accelRate = 0.2;
  else player.accelRate = 0;
  //if(accelerating)
  //{
  // player.acceleration.x = player.accelRate * sin(player.direction.heading());
  // player.acceleration.y = -player.accelRate*cos(player.direction.heading());
  //}
  //else player.accelRate = 0.2;
  
  player.update();
  player.display();
}

void keyPressed()
{
 if(keyCode == RIGHT) turning = 2;
 else if(keyCode == LEFT) turning = 1;
 else if(keyCode == UP) accelerating = true;
}

void keyReleased()
{
 if(keyCode == RIGHT || keyCode == LEFT) turning = 0;
 if(keyCode == UP) accelerating = false;
}