/*

How to Steal From Google
blprnt@blprnt.com

- Sample sketch for NYTLabs Summmer School 8/14/12

*/
PImage urljpg;

void setup() {
  size(600,600);
  background(0);
  stroke(255);
  getSatImage(query, zl);
  
}

void draw() {
  image(urljpg,0,0,width,height);
}



