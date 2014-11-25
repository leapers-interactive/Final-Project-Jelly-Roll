class Bat {
  
  PVector location;
  PVector acceleration;
  PVector velocity; 
  
  Bat(){
    
    location = new PVector(width+40, random(height/2-80,height/2+80));
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    
  }
  
  
  void update(){
    
    PVector target = new PVector(0,random(30,height-50));
    PVector dir = PVector.sub(target,location); 
    dir.normalize();
    dir.mult(0.3);
    acceleration = dir; 
    velocity.add(acceleration);
    velocity.limit(2);
    location.add(velocity); 
   
  }
  
  void display(){
    
    stroke(0);
    fill(175); 
    ellipse(location.x,location.y,10,10);
    
  }
  
  
  
}
