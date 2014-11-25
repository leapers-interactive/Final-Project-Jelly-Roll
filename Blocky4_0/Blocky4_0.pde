import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.processing.LeapMotion;
import com.leapmotion.leap.Vector; 

// make it go faster 
// be creative!
// try somethi



import fisica.*;

// Leap

LeapMotion leap; 
// physics 
PImage eyes; 
int state; 
FWorld world;
Blob b;


ArrayList<Obstacles> ob;
ArrayList<Platform> hills; 
ArrayList<FLine> lines; 
ArrayList<Float> points; 
ArrayList<Shooter> s; 
FLine firstLine; 
Platform firstHill;
PImage jellyBackground;
Vector rightHandPosition; 
int fingers = 0; 

void setup(){
  
  // leap 
  
  leap = new LeapMotion(this);
  // physics 
  jellyBackground = loadImage("start_screen.png");
  
  // set state
  
  state = 0; 
  size(1000, 400);
  rightHandPosition = new Vector(0,0,0);
  // set world 
  Fisica.init(this); 
  world = new FWorld(); 
  world.setGravity(0, 300);
  
  
  hills = new ArrayList<Platform>(); 
  lines = new ArrayList<FLine>(); 
  points = new ArrayList<Float>(); 
  ob= new ArrayList<Obstacles>(); 
  s= new ArrayList<Shooter>();
  
  b= new Blob(); 
  
  eyes = loadImage("eyes02.png");
  smooth(); 
  
  // set at the center of the blob
   firstLine = new FLine(width/2-40,height/2+20, width/2,height/2+20);
   firstHill = new Platform(width/2-40,height/2+20);
   
   // i would need to know where the previous x is to connect it to the next line
   firstLine.setStatic(true); 
   firstLine.setStrokeWeight(2);
   firstLine.setStroke(183,146,245); 
   
   lines.add(firstLine);  // add line to arrayListy
   float firstHeight = height/2+20;
   points.add(firstHeight); // add the height location of the first line to the array 
   world.add(firstLine); 
   hills.add(firstHill); 
}


float count = 0; 
float xPos = width/2; 
float yPos = 0;

void draw(){

   if(state == 0){
     
     // sample start screen
     imageMode(CENTER);
     image(jellyBackground, width/2,height/2);
     float mintargetX = width/2 -20;
     float mintargetY = height/2 -20;
     float maxtargetX = width/2 +20;
     float maxtargetY =  width/2 + 20; 
     if(mousePressed &&  mouseX > mintargetX && mouseX < maxtargetX && mouseY > mintargetY && mouseY < maxtargetY){
       state = 1; 
     }
     
     
     
   }
  
  
  if( state == 1){
   
   background(255);
    
   if(frameCount % 20 == 0  && fingers == 0){
     Shooter sh = new Shooter(b.getX(),b.getY());
     s.add(sh); 
   }
  
   for(int i = 0; i< s.size(); i++){
     Shooter sh = s.get(i);
     sh.update();
     sh.display();
     if(sh.leftScreen()){
       s.remove(sh);
     }
   }
   
   if(b.getX() > width/2-40){
     // add force so it doesn't fall
     b.pushBack();
   }
   
   if(b.getX() <  width/2-80){
     // add force so it doesn't fall
     b.pushFront();
   
   }
   
   // pick an obstalcle 
   if((frameCount % 190) == 0){ 
     
     // distribute them 
     float num = random(1); 
     
     // between 0 and fourty create the top obstacle 
     // 35 % 
     if(num < 0.35){
         Obstacles st= new Stalagtite(random(75,230)); 
         ob.add(st);
     }
    
     //35%
     else if(num<0.70){
         Obstacles sm = new Stalagmite(random(230,height - 75));
         ob.add(sm);
     }
     
     //10 %
     else if(num < 0.80){
       
     }
     
     // 20% 
     else{
         // have the difference between them be 50 
         float randomSt = random(75,230);
         float smHeight = randomSt + 70;
         Obstacles st = new Stalagtite(randomSt);
         Obstacles sm= new Stalagmite(smHeight);
         ob.add(st);
         ob.add(sm);
     }
   

     }
   
   // loop through obstacle 
   for(int i = 0; i<ob.size(); i++)
   {
     Obstacles o = ob.get(i);
     o.update();

     // check for collision with the blob 
     if(o.hit(b.getBlob())){
         b.decreaseLife(); 
         b.removeFromWorld();
     }
     if(o.location.x < - 600 ){
       ob.remove(o); 
       o.removeWorld();
     }
   }
   
   
   // create a new platform at everyframe count 
   if((frameCount % 1) == 0){
    
    // get the lastest point 
     int i = points.size()-1; 
     Float chosenY = points.get(i);
     
     // get new mouse location
     // replace mouseY with the y location of hand 
     float mouseyLocation = height - rightHandPosition.getY(); 
     
     // create a new line
 
     FLine l = new FLine(width/2,chosenY, width/2+2,mouseyLocation);
     l.setStatic(true);
     l.setStrokeWeight(2); 
     l.setStroke(183,146,245);
     l.setNoFill();
     // create a new platform
     Platform h = new Platform(width/2,mouseyLocation);
     //add everything to their respective lists
     points.add(mouseyLocation);
     lines.add(l);
     world.add(l);
     hills.add(h); 
     
   
    
   }


// only compute size once-- all three arrays have the same size
   for(int i = 0; i< hills.size(); i++){
     
     Platform h = hills.get(i); 
     FLine li = lines.get(i);
     Float p = points.get(i);
     
     // adjust accordingly
     li.adjustPosition(-2,0); 
     h.adjust();
     
     // display hills too
     // h.display(); 
     
     if(h.location.x-10 < 0){
       // get X location from hill
       lines.remove(li);
       world.remove(li); 
       hills.remove(h);
       points.remove(p); 
     }
     
   }
 
   world.step();
   world.draw();
  
   
   imageMode(CORNER);
   image(eyes,b.getX()-10,b.getY()-20);
 
 }
 
 }
 
 
 
 Vector fingerPosition (final Controller controller){
  

    if (controller.isConnected())
    {
        Frame frame = controller.frame();
        if (!frame.hands().isEmpty())
        {
          for (Hand hand : frame.hands())
          {
            
            if(hand.isRight()){
              
              Vector finger_stabilized = hand.stabilizedPalmPosition();
              return finger_stabilized; 
            }
            
          }
        }
  
    }
    
  Vector none = new Vector(width/2,height/2,0);
  return none; 
 
}
  
// count extended fingers
int countExtendedFingers(final Controller controller)
{
  int fingers = 0;
  if (controller.isConnected())
  {
    Frame frame = controller.frame();
    if (!frame.hands().isEmpty())
    {
      for (Hand hand : frame.hands())
      {
        int extended = 0;
        for (Finger finger : hand.fingers())
        {
          if (finger.isExtended())
          {
            extended++;
          }
        }
        fingers = Math.max(fingers, extended);
      }
    }
  }
  return fingers;
}
 
 
// leap required  
void onFrame(final Controller controller)
{
  fingers = countExtendedFingers(controller);
  rightHandPosition = fingerPosition(controller);
}

void keyPressed()
{
  if (key == ' ')
  {
    b.jump(lines);
  }
}

