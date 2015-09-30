class Tree
{
  float x, y;
  float speed;
  float age = 0, maxAge; //Lets us know when the tree can be safely removed. Check removeOldClouds() in the main class for more details, it works the same as for trees
  
  Tree()
  {
    //Generates random coordinates for the tree using a Gaussian distribution so we'll be more likely to have clusters of trees, like woods
    x = 150*randomGaussian() + width/2;
    while(x<width) x += width;
    y = 100*randomGaussian() + height/2;
    if(y<=height/3) y = height/3 + random(100, 200);
    this.maxAge = width/speed+50;
  }
  
  void display()
  {
    image(tree, x, y, tree.width, tree.height);
    x -= 3;
    age++;
  }
}