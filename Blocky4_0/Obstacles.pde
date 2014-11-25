public abstract class Obstacles{
  
  PVector location;
  abstract void update();
  abstract void removeWorld();
  abstract boolean hit(FBlob b);
  abstract void display();
  
}
