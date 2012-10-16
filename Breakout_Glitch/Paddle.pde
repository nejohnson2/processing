public class Paddle {
  Rectangle rectangle;
  // PADDLE PROPERTIES --
  int width = 60;
  int height = 5;
  boolean hasStroke = false;
  color strokeColor = #FFFFFF;
  boolean hasFill = true;
  color fillColor = #ffffff << 3;
  
  int x = gameFrameWidth/2;
  int y = 270;
  
  Paddle() {
    rectangle = new Rectangle(width >> 1, height<<1, hasStroke, strokeColor, hasFill, fillColor);
    rectangle.setPosition(x>>2, y);
  }

  void refresh() {
    updatePosition();
    rectangle.setPosition(x, y);
    rectangle.drawYourself();
  }

  void updatePosition() {
    x = mouseX >> 2;//-width/2; //mouseX-rectX-width/2
    //x = constrain(x, 0, gameFrameWidth); //gameFrameWidth-width
  }
}

