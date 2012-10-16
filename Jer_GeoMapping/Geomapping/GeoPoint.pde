class GeoPoint{
  
 float lat;
 float lon;
 
 PVector pos = new PVector();
 PVector tpos = new PVector();
 
 Date theDate;
 
 void update() {
   // Do what ever you do 
   
   pos.lerp(tpos, 0.1);
   
 }
 
 void render() {
   // Update to the screen
   
   pushMatrix();
     translate(pos.x, pos.y);
     noStroke();
     fill(255,10);  // change this its cool.  to see most visitied places
     rect(0,0,5,5);
   
   popMatrix();
   
 }
  
}
