class Platform
{
  // World where the platform exists
  FWorld world;
  
  // Array list to hold all of the boxes in the platform
  ArrayList<PBox> boxes;  
  
  // Size of the boxes in the platform
  float bSize;
  
  // Constructor
  Platform(FWorld world, float bSize) 
  {
    this.world = world;
    this.bSize = bSize;
    boxes = new ArrayList<PBox>();
  }
  
  // Adds dX and dY to the x and y positions, respectively, of all
  // boxes in the platform
  void move(float dX, float dY)
  {
    if (!boxes.isEmpty())
    {
      for (int i = 0; i < boxes.size(); i++)
      {
        boxes.get(i).move(dX, dY);
      }
    }
  }
  
  // Adds a box to the platform
  void addBox(float x, float y)
  {
    boxes.add(new PBox(world, x, y, bSize));
  }
  
  // Removes the last box in the array list
  void removeEndBox()
  {
    if (!boxes.isEmpty())
    {
      // Remove the FBox from the world
      boxes.get(0).removeBox();
      // Remove the PBox from our list
      boxes.remove(0);
    }
  }
  
  // Returns a boolean telling if the last box is off the screen
  boolean endBoxOffScreen()
  {
    if (!boxes.isEmpty())
    {
      return boxes.get(0).isOffScreen();
    } 
    else
    {
      return false;
    }
  }
  
  // Get methods
  
  // Returns the number of boxes in the platform
  int getNumBoxes() { return boxes.size(); }
  
  // Returns the PBox at index i
  PBox getBox(int i) { return boxes.get(i); }
  // Returns the x position of the last box in the list
  // Returns -1 if the list is empty
  float getHeadX()
  {
    if (!boxes.isEmpty()) return boxes.get(boxes.size() - 1).getX();
    else return -1;
  }
  // Returns the y position of the last box in the list
  // Returns -1 if the list is empty
  float getHeadY()
  {
    if (!boxes.isEmpty()) return boxes.get(boxes.size() - 1).getY();
    else return -1;
  }
}
