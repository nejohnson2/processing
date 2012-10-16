class GeoPoint {
  
  float lat;
  float lon;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  Date theDate;
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y);
      noStroke();
      fill(255,20);
      rect(0,0,5,5);
    popMatrix();
  }
}





