class Blob
{
  // FBlob
  FBlob blob;
  
  // Number of vertices in the blob
  float vCount = 0;
  
  // Constructor
  Blob(FWorld world, float startX, float startY, float size, int vCount)
  {
    this.vCount = vCount;
    
    blob = new FBlob();
    blob.setAsCircle(startX, startY, size, vCount);
    blob.setStroke(52, 73, 94);
    blob.setStrokeWeight(3);
    blob.setFill(46, 204, 113);
    blob.setFriction(4);
    
    // Add the blob to the world
    world.add(blob);
  }
  
  // Jump method for the blog (blob can only jump when touching
  // and on top of a box in the platform)
  void jump(Platform p)
  {
    for (int i = 0; i < p.getNumBoxes(); i++)
    {
      // Check if the blob is touching the box and above it
      if (isTouchingBody((FBody)p.getBox(i).getFBox()) &&
          getY() < p.getBox(i).getY())
      {
       addForce(0, -jumpForce);
       return;
      }
    }
  }
  
  // Applies a force to the blob
  void addForce(float fX, float fY)
  {
    blob.addForce(fX, fY);
  }
  
  // Get methods
  float getX() 
  {
    float x = 0;
    for (int i = 0; i < blob.getVertexBodies().size(); i++)
    {
      x += ((FBody)blob.getVertexBodies().get(i)).getX();
    }
    x /= vCount;
    
    return x;
  }

  float getY()
  {
    float y = 0;
    for (int i = 0; i < blob.getVertexBodies().size(); i++)
    {
      y += ((FBody)blob.getVertexBodies().get(i)).getY();
    }
    y /= vCount;
    
    return y;
  }
  
  // Returns true if one of the vertices of this blob is touching
  // the FBody passed in
  boolean isTouchingBody(FBody body)
  {
    for (int i = 0; i < blob.getVertexBodies().size(); i++)
    {
      if (((FBody)blob.getVertexBodies().get(i)).isTouchingBody(body))
      {
        return true;
      }
    }
    return false;
  }
}
