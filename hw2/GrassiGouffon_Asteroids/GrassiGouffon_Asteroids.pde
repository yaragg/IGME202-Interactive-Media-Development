Ship player;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
int turning = 0; //0 = not turning, 1 = left, 2 = right
boolean accelerating = false;
int maxBulletsOnScreen = 5;

void setup()
{
  size(600, 600);
  player = new Ship();
  asteroids.add(new Asteroid());
  rectMode(CENTER);
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
  
  //if(turning == 1) player.direction.rotate(0.1);
  //else if(turning == 2) player.direction.rotate(-0.1);
  if(turning == 1) player.directionAngle += 0.1;
  else if(turning == 2) player.directionAngle -= 0.1;
  
  //player.accelRate = 0.1;
  if(accelerating) player.accelRate = 0.2;
  else player.accelRate = 0;
  //if(accelerating)
  //{
  // player.acceleration.x = player.accelRate * sin(player.direction.heading());
  // player.acceleration.y = -player.accelRate*cos(player.direction.heading());
  //}
  //else player.accelRate = 0.2;
  
  for(int i=0; i<asteroids.size(); i++)
  {
    asteroids.get(i).update();
    asteroids.get(i).display();
  }
  
  for(int i=0; i<bullets.size(); i++)
  {
    bullets.get(i).update();
    bullets.get(i).display();
  }
  
  player.update();
  player.display();
  
  destroyBullets();
}

void destroyBullets()
{
  for(int i=0; i<bullets.size(); i++)
  {
    if(bullets.get(i).age > Bullet.maxBulletAge || bullets.get(i).destroy == true)
    {
      bullets.remove(i);
      i--;
    }
  }
}

void keyPressed()
{
 if(keyCode == RIGHT) turning = 2;
 else if(keyCode == LEFT) turning = 1;
 else if(keyCode == UP) accelerating = true;
 if(key == ' ') player.fire();
}

void keyReleased()
{
 if(keyCode == RIGHT || keyCode == LEFT) turning = 0;
 if(keyCode == UP) accelerating = false;
}