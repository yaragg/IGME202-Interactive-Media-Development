Ship player;
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
int turning = 0; //0 = not turning, 1 = left, 2 = right
boolean accelerating = false;
static final int maxBulletsOnScreen = 5;
static final int maxAsteroidsOnScreen = 7;
boolean playing;

void setup()
{
  size(600, 600);
  rectMode(CENTER);
  startGame();
}

void startGame()
{
  player = new Ship();
  asteroids = new ArrayList<Asteroid>();
  bullets = new ArrayList<Bullet>();
  turning = 0;
  accelerating = false;
  playing = true;
  fill(#FFFFFF);
}

void draw()
{
 if(playing) gameLoop();
 else
 {
   textSize(30);
   fill(#000000);
   text("Game over. Continue? (y/n)", 60, height/2);
   if(key == 'y' || key == 'Y')
     startGame();
   else if(key == 'n' || key == 'N') exit();
 }
}

void gameLoop()
{
    background(180);
  
  if(turning == 1) player.directionAngle += 0.1;
  else if(turning == 2) player.directionAngle -= 0.1;
  if(accelerating) player.accelRate = 0.2;
  else player.accelRate = 0;
  
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
  destroyAsteroids();
  
  if(frameCount%70 == 0 && random(0, 2) < 0.7 && asteroids.size()<maxAsteroidsOnScreen) asteroids.add(new Asteroid());
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

void destroyAsteroids()
{
  for(int i=0; i<asteroids.size(); i++)
  {
    if(asteroids.get(i).destroy == true)
    {
      asteroids.remove(i);
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