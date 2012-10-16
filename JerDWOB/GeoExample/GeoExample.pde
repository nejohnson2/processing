SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
ArrayList<GeoPoint> pointList = new ArrayList();

Date startTime;
Date endTime;
Date currentTime;

long millisPerFrame = 1000 * 60 * 60 * 10;

void setup() {
  size(800,600);
  smooth();
  background(0);
  loadGeo();
  mapWorld();
  
  endTime = pointList.get(pointList.size() - 1).theDate;
  startTime = pointList.get(0).theDate;
  currentTime = startTime;
}

void draw() {
  background(0);
  
  currentTime = new Date(currentTime.getTime() + millisPerFrame);
  if (currentTime.getTime() > endTime.getTime()) {
   currentTime = startTime; 
  }
  fill(255);
  text(currentTime.toString(), 50, 50);
  
  //translate(width/2, height/2);
  
  for(GeoPoint p:pointList) {
    p.update();
    if(p.theDate.getTime() < currentTime.getTime()) p.render();
  }
}

void loadGeo() {
  //Import the CSV
  String[] input = loadStrings("openpaths_house.csv");
  //For each line in the CSV, make a GeoPoint object
  for(int i = 1; i < input.length; i++) {
    //Make a new GeoPoint
    GeoPoint gp = new GeoPoint();
    String[] splits = input[i].split(",");
    gp.lat = float(splits[0]);
    gp.lon = float(splits[1]);
    String dateString = splits[3];
    try {
      gp.theDate = sdf.parse(dateString);
    } catch(Exception e) {
      println("ERROR PARSING DATE!" + e);
    }
    
    pointList.add(gp);
    //gp.tpos = getXY(gp.lat, gp.lon);
  }
}

void mapWorld() {
  PVector tl = new PVector(-180,90);
  PVector br = new PVector(180,-90);
  
  for(GeoPoint gp:pointList) {
    gp.tpos = getXY(gp.lat, gp.lon, tl, br);
  }
}

void mapNYC() {
  PVector tl = new PVector(-74.2557349,40.9152414);
  PVector br = new PVector(-73.7002721,40.4959080);
  
  for(GeoPoint gp:pointList) {
    gp.tpos = getXY(gp.lat, gp.lon, tl, br);
  }
}

PVector getXY(float lat, float lon, PVector tl, PVector br) {
  float x = map(lon, tl.x, br.x, 0, width);
  float y = map(lat, tl.y, br.y, 0, height);
  PVector out = new PVector(x,y);
  return(out);
}

void mousePressed() {
 mapNYC(); 
}














