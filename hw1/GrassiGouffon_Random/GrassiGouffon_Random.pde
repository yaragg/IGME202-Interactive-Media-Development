import ddf.minim.*;

Bird a, b, c;
float mountainAtime = 0.0, mountainBtime = 100.0; //Where each mountain is relative to the Perlin noise pattern.
//Mountain A is the one in the back, B is the one closest to the viewer

PImage body, wing, tree;

ArrayList<Cloud> clouds = new ArrayList<Cloud>();

AudioPlayer audio; //Plays the background music
AudioPlayer sfx; //Plays the bird call
Minim minim;

float nextSfx; //Indicates when to play the sfx

void setup()
{
  size(500, 500);
  
  //Loads images and creates objects
  a = new Bird(200, 200, color(255, 0, 0), 0.005);
  b = new Bird(300, 100, color(0, 0, 180), 0.005);
  c = new Bird(500, 400, color(180, 0, 180), 0.005);
  body = loadImage("body.png");
  wing = loadImage("wing.png");
  tree = loadImage("tree.png");
  
  //Creates audio objects
  minim = new Minim(this);
  audio = minim.loadFile("Wings.mp3", 2048);
  audio.setGain(-13);
  sfx = minim.loadFile("Eaglet Bird 2.mp3", 2048);
  sfx.setGain(-11);
  audio.loop();
  nextSfx = random(40, 200); //Randomly decides when to first play the sfx
}

void stop()
{
  //Stops the audio
  audio.close();
  minim.stop();
  super.stop();
}

void drawBackground()
{
  drawSky();
  mountainAtime = drawMountain(0.005, 0.007, 4*height/9, 0, mountainAtime);
  fill(color(98, 222, 75));
  rect(0, height/3, width, 2*height/3);
}

void drawForeground()
{
  mountainBtime = drawMountain(0.005, 0.022, height, 3*height/9, mountainBtime);
}

void drawSky()
{
  fill(color(129, 194, 255));
  rect(0, 0, width, height/3);
}

//mt is where the mountain is relative to the Perlin noise sequence
//base and top are where is the foot of the mountain and the highest value its peaks can reach, respectively
//xstep controls the smoothness of the mountain. The lowest its value, the smoother it will be
//speed affects how fast the mountain will pass by the screen
float drawMountain(float xstep, float speed, float base, float top, float mt)
{
  float my;
  float xoff = mt;
  float max = base;
  float min = top;
  
  noStroke();
  fill(118, 156, 52);
  beginShape();
  for (int i = 0; i < width; i++) 
  {
    my = map(noise(xoff), 0, 1, min, max);
    xoff += xstep;
    vertex(i, my);
  }
  vertex(width, base);
  vertex(0, base);
  endShape();
  mt += speed;
  return mt; //Returns mt so it can be saved and used for the next call
}



void draw()
{
  if(frameCount>=nextSfx) //Is it time to play the sfx?
  {
    if(!sfx.isPlaying()) 
    {
      sfx.rewind();
      sfx.play();
    }
    nextSfx += random(300, 800); //Decides when will be the next time it will be played
  }
  
  background(180);
  drawBackground();
  a.display();
  b.display();
  c.display();
  drawForeground();
  for(int i=0; i<clouds.size(); i++) clouds.get(i).display(); //Displays all clouds

  //Every 100 frames, checks for any clouds that need to be destroyed
  if(frameCount%100==0) removeOldClouds(); 
  
  cloudGeneration();

}

void removeOldClouds()
{
  for(int i=0; i<clouds.size(); i++)
  {
    //If the cloud has passed its maximum age, chances are it's already disappeared off screen so it can be safely removed
    //Since no one is pointing to the cloud anymore, the garbage collector should eventually free up the memory
    if(clouds.get(i).age>=clouds.get(i).maxAge) 
    {
      clouds.remove(i);
      i--;
    }
  }
}

void cloudGeneration()
{
  if(frameCount%40==0) //Every 40 frames, decides whether to generate a new cloud
  {
    if(random(0, 1)<0.4)
    {
      //Decides what kind of cloud it will be:  
      //One that is close to the viewer (so a larger cloud that passes by quickly due to parallax), a medium one, or a small one far away that moves by slower
      float r = random(0, 1);
      if(r<0.3) //Adds to the "foreground" region - big clouds on the lower part of the screen with higher speed
        clouds.add(new Cloud (2*height/3, height, random(80, 120), 7));
      else if(r<0.6) //Adds to the middle part
        clouds.add(new Cloud (height/3, 2*height/3, random(50, 60), 3));
      else //Adds to the background far away
        clouds.add(new Cloud (0, height/3, random(25, 40), 2));
    }
  }
}