PImage img;

void setup() { 
  img = loadImage("/Users/Luce/Desktop/Brac.jpg");
  size(img.width, img.height);
  //frameRate(1);
}

void draw() {
  if(frameCount % 2 == 0) {
    img.copy(img, 0, 0, width-1, height-1, 1, 1, width-1, height-1);
  } else {
    img.copy(img, 1, 1, width-1, height-1, 0, 0, width-1, height-1);
  }
  //img.resize(int(img.width * 1.01), int(img.height * .99));
  if(frameCount % 2 == 0 ) {  
    img.save("beeout.jpg");
    img = loadImage("beeout.gif");
  } else{
    img.save("beeout.jpg");
    img = loadImage("beeout.jpg");
  }
  image(img, 0,0, width, height);
  
  
}
