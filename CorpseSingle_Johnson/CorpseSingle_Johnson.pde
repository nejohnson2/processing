PImage img;

void setup() {
  size(512, 512, JAVA2D);
  img = loadImage("marylin.jpg");
  img.loadPixels();
  img = glitch(img);
  img.updatePixels();
  image(img, 0, 0);
}

PImage glitch(PImage img) {
  img.save("data/glitch-out.jpg");
  byte raw[] = loadBytes("glitch-out.jpg");
  int i = 0;
  while (! (raw[i] == (byte) 0xff && raw[i+1] == (byte) 0xda) &&
    i < raw.length - 1) {
    i++;
  }
  while (i < raw.length) {
    if (raw[i] == 10) {
      //raw[i]++;
      raw[i] =byte(raw[i]>>1);
    }
    if (raw[i] == 100) {
      raw[i] = byte(raw[i]<< 2);
    }
    i++;
  }
  saveBytes("data/glitch-out.jpg", raw);
  img = loadImage("glitch-out.jpg");
  for (int j = 0; j < 280; j++) {
    if (frameCount % 2 == 0) {
      img.copy(img, 0, 0, width-1, height-1, 1, 1, width-1, height-1);
    } 
    else {
      img.copy(img, 1, 1, height-1, width-1, 0, 0, width-1, height-1);
    }
  }
  colorMode(HSB, 255);
  int n = img.width * img.height;
  for(int k=0; k<n; k++) {
    color cur = img.pixels[k];
    int h = int(hue(cur));
    int s = int(saturation(cur));
    int b = int(brightness(cur));
    if(frameCount % 2 == 0){
      b = int(brightness(cur)) << 1;
    }
    else {
      b = int(brightness(cur)) >> 3;
    }
    img.pixels[k] = color(h,s,b);
  }
  img.updatePixels();
  img.copy(img, 1, 1, width-1,height-1,0,0, height-1,width-1);
  image(img, 0, 0, width, height); 
  return img;
}

