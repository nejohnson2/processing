// some xor'ing encode / decode routines
PImage kcm304_0(PImage img) {
  int n = img.width * img.height;
  for (int i = 0; i < n; i++) {
    color cur = img.pixels[i];
    int r = int(red(cur));
    int g = int(green(cur));
    int b = int(blue(cur));
    int k = i % 256;
    r = k^flipnib(k^flipopp(k^r));
    g = k^flipnib(k^flipopp(k^g));
    b = k^flipnib(k^flipopp(k^b));
    img.pixels[i] = color(r, g, b);
  }
  return img;
}

PImage kcm304_1(PImage img) {
  int n = img.width * img.height;
  for (int i = 0; i < n; i++) {
    color cur = img.pixels[i];
    int k = i % 256;
    int r = int(red(cur));
    int g = int(green(cur));
    int b = int(blue(cur));
    r = k^flipopp(k^flipnib(k^r));
    g = k^flipopp(k^flipnib(k^g));
    b = k^flipopp(k^flipnib(k^b));
    img.pixels[i] = color(r, g, b);
  }
  return img;
}

int flipnib(int x) {return ((x&15)<<4)|((x&240)>>4);}
int flipopp(int x) {return ((x&170)>>1)|((x&85)<<1);}

// basic Processing filters
PImage kcm304_2(PImage img) {
  img.filter(INVERT);
  img.filter(ERODE);
  img.filter(POSTERIZE, 4);
  return img;
}

// save and reload as a GIF
PImage kcm304_3(PImage img) {
  img.save("data/out.gif");
  return loadImage("out.gif");
}

// save and reload as a JPG, plus databend
PImage kcm304_4(PImage img) {
  img.save("data/glitch-out.jpg");
  byte raw[] = loadBytes("glitch-out.jpg");
  int i = 0;
  // skip the jpeg header
  while (!(raw[i] == (byte) 0xff && raw[i+1] == (byte) 0xda) &&
      i < raw.length - 1) {
    i++;
  }
  // modify the remaining bytes
  while(i < raw.length) {
    if(raw[i] == 10) {
      raw[i]++;
    }
    i++;
  }
  saveBytes("data/glitch-out.jpg", raw);
  img = loadImage("glitch-out.jpg");
  return img;
}

// minmal c style
PImage kcm304_5(PImage img) {
  int n = img.width * img.height;
  for (int i = 0; i < n; i++) {
    color cur = img.pixels[i];
    int r = int(red(cur)), g = int(green(cur)), b = int(blue(cur));
    int off = i*5&(i>>7)|i*3&(i*4>>10); // miiro
    off %= 256; // don't let the offset overflow
    // shuffle channels and xor with minimal c data
    img.pixels[i] = color(
      g ^ off,
      b ^ off,
      r ^ off);
  }
  return img;
}
PImage nick(PImage img) {
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

// use PGraphics to draw like usual
PImage kcm304_6(PImage img) {
  PGraphics pg = createGraphics(512, 512, JAVA2D);
  pg.beginDraw();
  pg.background(0);
  pg.image(img, 0, 0);
  pg.pushMatrix();
  pg.rotate(.1);
  pg.scale(1.05);
  pg.image(img, 0, 0);
  pg.popMatrix();
  pg.noFill();
  pg.stroke(255);
  pg.strokeWeight(4);
  pg.ellipse(256, 256, 512, 512);
  pg.endDraw();
  return pg;
}
