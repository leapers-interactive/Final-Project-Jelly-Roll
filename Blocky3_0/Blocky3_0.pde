import fisica.*;
import de.voidplus.leapmotion.*;
import development.*;

// Our world for the game
FWorld world;

// How fast does the game scroll to the side (px/frame)
float scrollSpeed = 1;

// The blob character
Blob blob;

// x, y positions for the blob
float blobX;
float blobY;

// X position that blob x will gravitate towards
float xPos;

// Blob jump force
float jumpForce = 2500;

// Platform object
Platform platform;

// Size of the boxes for the platform
float box_size = 5;

// X position where new boxes are drawn
float box_x;


void setup() {

  size(displayWidth, displayHeight);
  Fisica.init(this); 
  world = new FWorld(); 
  world.setGravity(0, 500);

  // set xPos
  xPos = width/3;

  // Blobs x, y positions, size, and vertex count
  blobX = xPos;
  blobY = height/2;
  float blobSize = 30;
  int blobVCount = 20;

  // Create the blob
  blob = new Blob(world, blobX, blobY, blobSize, blobVCount);
  
  // Box x position
  box_x = width/2;

  platform = new Platform(world, box_size);
  
  // Add a starting platform to the screen so the blob doesn't fall
  // off (use PY as the boxes y pos)
  float PY = height*2/3;
  for (int i = 0; i < box_x/box_size; i++)
  {
    // Create the boxes in a line along PY
    platform.addBox(i*box_size, PY);
  }

}

void draw() {  
  background(255); 
  // Determine the blobs x value
  blobX = blob.getX();

  // Keep the blob gravitating toward xPos
  maintainBlobXPos();
  
  // Update the platform
  updatePlatform();
  
  // Steadily move the world to the left
  sideScroll(scrollSpeed);



  // Update and draw the world
  world.step();
  world.draw();
  
  // debugging
  fill(255, 0, 0);
  ellipse(platform.getHeadX(), platform.getHeadY(), 10, 10);
  ellipse(blobX, blob.getY(), 10, 10);
  
  line(width/3, 0, width/3, height);
  
  if (blob.blob.getTouching().size() > 0)
  {
    println("TOUCH!");
  }
}

// Moves everything in the game to the left except for the blob
void sideScroll(float speed)
{
  // Move the platform
  platform.move(-speed, 0);
}

// Adds a new box to the platform if there is room
// Removes the last box in the platform if it's off the screen
void updatePlatform()
{
  // Check if there is room for a new box
  if (platform.getHeadX() <= (box_x - box_size))
  {
    // Add the box
    platform.addBox(box_x, mouseY);
  }
  
  // Check if the end box is off the screen
  if (platform.endBoxOffScreen())
  {
    // Remove the last box
    platform.removeEndBox();
  }
}

// Applies force to the blob proportional to its distance from
// xPos to move it towards blobX
void maintainBlobXPos()
{
  if (blobX > xPos || blobX < xPos)
  {
    blob.addForce( xPos - blobX , 0 );
  }
}

void keyPressed()
{
  if (key == ' ')
  {
    blob.jump(platform);
  }
}
