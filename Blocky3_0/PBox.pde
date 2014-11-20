// Platform Box class
class PBox
{
  // FBox 
  FBox box;
  
  // Size of the box
  float size;
  
  // Boolean to tell if the box's "enter the screen" animation
  // is complete
  boolean isSet;
  
  // Constructor
  PBox(FWorld world, float x, float y, float size)
  {
    this.size = size;
    isSet = false;
    box = new FBox(size, 5);
    // Set the physics of the box
    box.setFill(0);
    box.setStatic(true);
    box.setFriction(1);
    // Start the box at the bottom of the screen IMPLEMENT!!
    box.setPosition(x, y);
    // Add the box to the world
    world.add(box);
  }
  
  // Adds dX and dY to the x and y pos of the box respectively
  void move(float dX, float dY)
  {
    box.setPosition( getX() + dX, getY() + dY );
  }
  
  // Removes the box from it's world
  void removeBox()
  {
    box.removeFromWorld();
  }
  
  // Tells whether or not the box is off the screen
  boolean isOffScreen()
  {
    if (getX() >= 0 - size && getX() <= width &&
        getY() >= 0 - size && getY() <= height)
    {
      return false;
    }
    else return true;
  }
  
  // Get Methods
  float getX() { return box.getX(); }
  float getY() { return box.getY(); }
  FBox getFBox() { return box; }
  float getSize() { return size; }
}
