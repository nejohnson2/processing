SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
ArrayList<GeoPoint> pointList = new ArrayList();

Date startTime;
Date endTime;
Date currentTime;

long millisPerFrame = 1000 * 60 * 60 * 10; // frames in a movice.  millis * sec * min


void setup() {
  size(800, 600);
  smooth();
  //background(0);
  loadGeo();
  mapWorld();
  
  endTime = pointList.get(pointList.size() - 1).theDate;
  startTime = pointList.get(0).theDate;
  currentTime = startTime;
}

void draw() {
  background(0);
  
  currentTime = new Date(currentTime.getTime() + millisPerFrame); //move time forward
  
  if(currentTime.getTime() > endTime.getTime()) {
    currentTime = startTime; 
  }
  
  fill(255); // put the time on the screen
  text(currentTime.toString(), 50, 50);

  for (GeoPoint p:pointList) {
    p.update();
    
    // Draw only if you happened in the past...not in the future 
    if(p.theDate.getTime() < currentTime.getTime()) {
      p.render();
    }
  }
}

void loadGeo() {
  // import csv
  String[] input = loadStrings("openpaths_house.csv");

  //start loop at one to avoid using the header in the csv file
  for (int i = 1; i< input.length; i++) {
    //make a new geopiont
    GeoPoint gp = new GeoPoint();
    String[] splits = input[i].split(",");
    gp.lat = float(splits[0]);
    gp.lon = float(splits[1]);

    // SimpleDateFormat = yyy-MM-dd kk:mm:ss
    String dateString = splits[3];
    try {
      gp.theDate = sdf.parse(dateString);
    } 
    catch(Exception e) {
      println("ERROR PARSING DATE!" + e);
    }

    pointList.add(gp);
//    gp.tpos = getXY(gp.lat, gp.lon);
  }
}

void mapWorld() { 
  PVector tl = new PVector(-180, 90); //top left point of the bounding box
  PVector br = new PVector(180, -90);

  for (GeoPoint gp:pointList) {
    gp.tpos = getXY(gp.lat, gp.lon, tl, br);
  }
}

void mapNYC() {
  
  // Values taken from google link:
  // http://maps.google.com/maps/geo?output=json&keyabcdefg&q=new+york
  PVector tl = new PVector(-74.2557349, 40.9152414); //top left point of the bounding box
  PVector br = new PVector(-73.7002721, 40.4959080); 

  for (GeoPoint gp:pointList) {
    gp.tpos = getXY(gp.lat, gp.lon, tl, br);
  }
}


// global function that returns a PVector
PVector getXY(float lat, float lon, PVector tl, PVector br) {

  float x = map(lon, tl.x, br.x, 0, width); //scale these nubers
  float y = map(lat, tl.y, br.y, 0, height);  // be sure to use minus.  Because from 0,0, lat up is positive, down is neg
  PVector out = new PVector(x, y);
  return(out);
}

void mousePressed() {
  mapNYC();
}


