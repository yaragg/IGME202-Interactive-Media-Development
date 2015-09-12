PShape p;
float scale = 1.0;
float scaleInc = -0.03;
void setup()
{
  size(500, 500);
  background(180);
  p = createShape();
  beginShape();
  p.vertex(0, 0);
  p.vertex(70, 0);
  p.vertex(70, 70);
  endShape();
  p.translate(100, 100);
  //p.scale(1, -1);
}

void draw()
{
  background(180);
  //p.translate(100, 100);
  pushMatrix();
  //translate(-100, -100);
  //translate(-100*scale, -100*scale);
  translate(100, 100);
  scale(1, scale);
  shape(p, -100, -100);
  popMatrix();
  //if(frameCount%10==0){
  scale += scaleInc;
  println(scale);
  println(scaleInc);
  //if(scale==0) scale = 
  if(scale<=-1.0 ) scaleInc = 0.03;
  else if(scale>=1.0) scaleInc = -0.03;
  //scale = -scale;
  //}
}