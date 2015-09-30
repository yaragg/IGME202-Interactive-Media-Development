import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GrassiGouffon_Asteroids extends PApplet {



Ship player;
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
int turning = 0; //0 = not turning, 1 = left, 2 = right
boolean accelerating = false;
static final int maxBulletsOnScreen = 5;
static final int maxAsteroidsOnScreen = 7;
boolean playing;
PImage asteroid_images[][] = new PImage[4][2];
PImage bullet_image;
PImage bg;
Minim minim;
AudioPlayer game_bgm;
AudioPlayer shot_sfx;
AudioPlayer explosion_b; //Big asteroid explosion
AudioPlayer explosion_s; //Small asteroid explosion
AudioPlayer ship_explosion;
PImage title_images[] = new PImage[2];
boolean title_screen = true;
int displayed_title = 0;

public void setup()
{
  
  imageMode(CENTER);
  
  //Load sounds
  minim = new Minim(this);
  game_bgm = minim.loadFile("8-Bit Bomber.mp3", 2048);
  game_bgm.setGain(-15);
  shot_sfx = minim.loadFile("shot.mp3", 2048);
  shot_sfx.setGain(-4);
  explosion_b = minim.loadFile("explosion_b.mp3", 2048);
  explosion_s = minim.loadFile("explosion_s.mp3", 2048);
  ship_explosion = minim.loadFile("ship_explosion.mp3", 2048);
  ship_explosion.setGain(-4);
  
  //Load main screen images
  title_images[0] = loadImage("title_screen_no_message.jpg");
  title_images[1] = loadImage("title_screen_with_message.jpg");
  
  //Load background image
  bg = loadImage("background.jpg");
  //Load images that will be shared by many objects (ie not ship images since there's only one)
  for(int i=0; i<4; i++)
  {
    asteroid_images[i][0] = loadImage("asteroid_"+i+"_b.png");
    asteroid_images[i][1] = loadImage("asteroid_"+i+"_s.png");
  }
  bullet_image = loadImage("bullet.png"); 
  game_bgm.loop();
  startGame();
}

public void startGame()
{
  player = new Ship();
  asteroids = new ArrayList<Asteroid>();
  bullets = new ArrayList<Bullet>();
  turning = 0;
  accelerating = false;
  playing = true;
  asteroids.add(new Asteroid()); //Add a single asteroid just so the player doesn't sit around waiting for the first one for too long
}

public void title()
{
  background(title_images[displayed_title]);
  if(frameCount%20 == 0) displayed_title = 1 - displayed_title;
}

public void draw()
{
 if(title_screen) title();
 else if(playing) gameLoop();
 else //Game over
 {
   background(bg);
   for(int i=0; i<asteroids.size(); i++) asteroids.get(i).display();
   player.displayExplosion();
   textSize(30);
   fill(0xffFFFFFF);
   text("Game over. Continue? (y/n)", 80, height/2);
   if(key == 'y' || key == 'Y')
     startGame();
   else if(key == 'n' || key == 'N') exit();
 }
}

public void gameLoop()
{
  background(bg);
  
  //Handle player rotating ship and accelerating
  if(turning == 1) player.directionAngle += 0.1f;
  else if(turning == 2) player.directionAngle -= 0.1f;
  if(accelerating) player.accelRate = 0.2f;
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
  
  //Check any bullets or asteroids should be destroyed
  destroyBullets();
  destroyAsteroids();
  
  //Every 70 frames, game has a 70% chance to generate a new asteroid provided it doesn't exceed the maximum amount of asteroids on screen
  if(frameCount%70 == 0 && random(0, 2) < 0.7f && asteroids.size()<maxAsteroidsOnScreen) asteroids.add(new Asteroid());
}

public void destroyBullets() //Remove asteroids that have exceeded their maximum age or hit an asteroid
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

public void destroyAsteroids()
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

public void mouseClicked()
{
  title_screen = false;
}

public void keyPressed() //Handles player input
{
 if(keyCode == RIGHT) turning = 2;
 else if(keyCode == LEFT) turning = 1;
 else if(keyCode == UP) //Changes ship image while using thrusters
 {
   accelerating = true;
   player.active_image = player.ship_thrusters;
 }
 if(key == ' ') player.fire();
}

public void keyReleased()
{
 if(keyCode == RIGHT || keyCode == LEFT) turning = 0;
 if(keyCode == UP) //Changes ship image back to normal
 {
   accelerating = false;
   player.active_image = player.ship_normal;
 }
}
 
public void stop()
{
  //Stops the audio
  game_bgm.close();
  minim.stop();
  super.stop();
}
class Asteroid extends GameObject
{
  boolean destroy = false; //Lets the game know whether to destroy this asteroid
  boolean entering = true; //Just spawned offscreen, need to ignore the screen wrapping so it doesn't just pop up in the screen
  boolean mini = false; //Has it already broken into smaller asteroids?
  int asteroidType; //Which of the four asteroid images should be used
  Asteroid()
  {
    super(0, 0, HALF_PI, 0.03f, 1);
    radius = 25;
    int side = (int) random(1, 5); //Decides which side of the screen the asteroid will come from
    
    //1 = top, 2 = right, 3 = bottom, 4 = left    
    if(side == 1) //Sets the asteroid to appear offscreen from the chosen side, and randomly selects the remaining coordinate
    {
      position.y = -2*radius;
      position.x = random(0, width);
    }
    else if(side == 2)
    {
      position.x = width + 2*radius;
      position.y = random(0, height);
    }
    else if(side == 3)
    {
      position.y = height + 2*radius;
      position.x = random(0, width);
    }
    else if(side == 4)
    {
      position.x = -2*radius;
      position.y = random(0, height);
    }
    
    asteroidType = (int) random(0, 4);
  } 
  
  //Constructor for the smaller asteroids
  //start is where the starting position, directionAngle is where it should head, and type is the asteroid type image
  Asteroid(PVector start, float directionAngle, int type)
  {
    super(start.x, start.y, directionAngle, 0.03f, 1);
    radius = 10;
    entering = false;
    mini = true;
    asteroidType = type;
  }
  
  public void wrapScreen()
  {
    if(!entering) super.wrapScreen();
  }
  
  public void checkCollisions() //Shouldn't be called since the Bullet and Ship classes handle checking
  {
  }
  
  public void update()
  {
    direction = PVector.fromAngle(atan2(player.position.y-position.y, player.position.x-position.x)); //Head towards player
    direction.normalize();
    super.move();
    if(position.x >= 0 && position.x < width && position.y >= 0 && position.y < height) entering = false; //Checks to see if the asteroid is already inside screen
  }
  
  public void display()
  {
    //Displays the proper asteroid image
    image(asteroid_images[asteroidType][PApplet.parseInt(mini)], position.x, position.y, asteroid_images[asteroidType][PApplet.parseInt(mini)].width, asteroid_images[asteroidType][PApplet.parseInt(mini)].height);
  }
  
}
class Bullet extends GameObject
{
  static final int maxBulletAge = 150; //How long a bullet can stay on the screen before vanishing. This allows for the bullets to wrap too, instead of destroying them when they go offscreen
  int age;
  boolean destroy = false;
  Bullet()
  {
    super(player.position.x, player.position.y, player.directionAngle, 0.5f, 3);
    radius = 4;
    age = 0;
  }
  
  public void checkCollisions() //Checks for collisions with asteroids
  {
    for(int i=0; i<asteroids.size(); i++)
    {
      if(isAHit(this, asteroids.get(i)))
      {
        destroy = true; //Mark bullet for destruction
        asteroids.get(i).destroy = true; //Mark asteroid for destruction
        if(!asteroids.get(i).mini) //If asteroid is big, divide in two
        {
          explosion_b.play();
          explosion_b.rewind();
          //Spawns the two smaller asteroids with a certain distance between them
          asteroids.add(new Asteroid(asteroids.get(i).position, asteroids.get(i).direction.heading(), asteroids.get(i).asteroidType));
          asteroids.add(new Asteroid(PVector.add(asteroids.get(i).position, new PVector(20, 20)), PI+asteroids.get(i).direction.heading(), asteroids.get(i).asteroidType));
        }
        else
        {
          explosion_s.play();
          explosion_s.rewind();
        }
        
      }
    }
  }
  
  public void update()
  {
    direction.normalize();
    super.move();
    age++;
  }
  
  public void display()
  {
    checkCollisions(); 
    //Displays the rotated bullet image
    pushMatrix();
    translate(position.x, position.y);
    rotate(direction.heading()-HALF_PI);
    image(bullet_image, 0, 0, 32, 32);
    popMatrix();
  }
}
//Asteroids, Bullets and Ships all inherit this class. This allows me to use a single collision detection method for all three, as well as centralize vector movement
abstract class GameObject
{
  PVector position, velocity, acceleration, direction;
  float accelRate, maxSpeed, radius;
  public abstract void checkCollisions();
  public abstract void update();
  public abstract void display();
  
  GameObject(float x, float y, float dir, float a, float ms) //Generic constructor for the subclasses to use
  {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    direction = PVector.fromAngle(dir);
    acceleration = new PVector(0, 0);
    accelRate = a;
    maxSpeed = ms;
  }
  
  public boolean isAHit(GameObject a, GameObject b) //Uses bounding circles to check if two elements have collided
  {
    if(pow(a.position.x - b.position.x, 2) + pow(a.position.y - b.position.y, 2) <= pow(a.radius + b.radius, 2))
        return true;
    else return false;
  }
  
  public void move()
  {
    //Direction should be set by the subclass before calling this method
    acceleration = PVector.mult(direction, accelRate);
    velocity.add(acceleration);
    if(this instanceof Ship) velocity.mult(0.99f); //Adds drag to player ship. Drag in vacuum? My Physics professor must be feeling sick now...
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.set(0, 0);
    wrapScreen();
  }
  
  public void wrapScreen() //Checks if object is at the edge of the screen and wraps
  {
    if(position.x>width) position.x = 0;
    else if(position.x<0) position.x = width;
    if(position.y>height) position.y = 0;
    else if(position.y<0) position.y = height;
  }

}
class Ship extends GameObject
{
  float directionAngle = -HALF_PI;
  PImage ship_thrusters, ship_normal, active_image; //active_image means which image should be displayed
  PImage explosion_animation[] = new PImage[7];
  int animation_step = 0;
  Ship()
  {
    super(width/2, height/2, -HALF_PI, 0, 5); //I would use directionAngle instead of -HALF_PI but it doesn't allow instance variables when calling the constructor
    radius = 10;
    ship_normal = loadImage("ship_no_thrusters.png");
    ship_thrusters = loadImage("ship_with_thrusters.png");
    active_image = ship_normal;
    
    for(int i=0; i<7; i++) explosion_animation[i] = loadImage("ship_explosion_"+i+".png");
  }
  
  public void displayExplosion()
  {
    if(animation_step < 6) image(explosion_animation[animation_step], position.x, position.y, explosion_animation[animation_step].width, explosion_animation[animation_step].height);
    if(frameCount%10 == 0 && animation_step<6) animation_step++;
  }
  
  public void checkCollisions() //Checks for collision with asteroids
  {
    for(int i=0; i<asteroids.size(); i++)
    {
      if(isAHit(this, asteroids.get(i)))
      {
        ship_explosion.play();
        ship_explosion.rewind();
        playing = false;
      }
    }
  }
  
  public void update()
  {
    direction = PVector.fromAngle(directionAngle);
    direction.normalize();
    super.move();
  }
  
  public void display()
  {
    checkCollisions();
    pushMatrix(); //Rotate ship and display
    translate(position.x, position.y);
    rotate(directionAngle+HALF_PI);
    image(active_image, 0, 0, 32, 32);
    popMatrix();
  }
  
  public void fire()
  {
    if(bullets.size()<maxBulletsOnScreen) //Only allow player to shoot if the maximum number of bullets on screen hasn't been exceeded
    {
      shot_sfx.play();
      shot_sfx.rewind();
      bullets.add(new Bullet());
    }
  }
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GrassiGouffon_Asteroids" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
