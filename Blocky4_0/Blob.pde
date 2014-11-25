class Blob{
  
  FBlob bobby;
  
  //FCircle bobby; 
  float size; 
  int lifeCount = 3;
  int vCount = 20;    // Vertex count
  Blob(){
    
   size = 30; 
  // bobby= new FCircle(size); 
   bobby= new FBlob(); 
   bobby.setAsCircle(width/2-20,height/2-40,40,20);
   bobby.setPosition(width/2 -40, height/2);
   bobby.setStroke(142, 68, 173);
   bobby.setStrokeWeight(3);
   bobby.setFill(155,89,182); 
   bobby.setFriction(4);
   bobby.setRestitution(1); 
   world.add(bobby); 
  }
  
  /*
  public void jump(){
    
    // it should be consistently jumping on its own 
    
    if(keyPressed){
      
      if (key==' '){
        bobby.addForce(3,-50);
      }
      
    }
   
  }*/
  
  public void resizeBlob(){
    
    size=-5;
    
  }
  
  
  
  public float getX() {
    
    
    float x = 0;
    for (int i = 0; i < bobby.getVertexBodies().size(); i++)
    {
      x += ((FBody)bobby.getVertexBodies().get(i)).getX();
    }
    x /= bobby.getVertexBodies().size();
    
    return x;
    
    
  }



  public float getY(){
    float y = 0;
    for (int i = 0; i < bobby.getVertexBodies().size(); i++)
    {
      y += ((FBody)bobby.getVertexBodies().get(i)).getY();
    }
    y /= bobby.getVertexBodies().size();
    
    return y;
  }
  
  public void pushFront(){
    
    bobby.addForce(10,0);
    
  }

  public void pushBack(){
    
    bobby.addForce(-10,0);
    
    
  }
  
  public FBlob getBlob(){
    
    return bobby;
    
  }
  
  public void removeFromWorld(){
    if(lifeCount==0)
    world.remove(bobby);
  }
  
  public void decreaseLife(){
    lifeCount--;
  }

  // Jump method for the blog (blob can only jump when touching
  // and on top of the platform)
  void jump(ArrayList<FLine> lines)
  {
    int numLines = lines.size();
    for (int i = 0; i < numLines; i++)
    {
      // Check if the blob is touching the box and above it
      if (isTouchingBody((FBody)lines.get(i))) //&& getY() < lines.get(i).getY())
      {
       bobby.addForce(3,-2000);
       return;
      }
    }
  }

  // Returns true if one of the vertices of this blob is touching
  // the FBody passed in
  boolean isTouchingBody(FBody body)
  {
    for (int i = 0; i < vCount; i++)
    {
      if (((FBody)bobby.getVertexBodies().get(i)).isTouchingBody(body))
      {
        return true;
      }
    }
    return false;
  }


  
}


