//Calibration objects
PVector topRight = new PVector();
PVector bottomLeft = new PVector();
boolean bounded = false;
ArrayList<LatLon> pointList = new ArrayList();
float border = 150;

//Function to get a lat/lon from a string
LatLon getLatLon(String s) {
  String url = "http://maps.google.com/maps/geo?output=csv&q=" + java.net.URLEncoder.encode(s);
  String[] input = loadStrings(url);
  String csv = input[0]; 
  String[] stringArray = csv.split(",");
  LatLon latLon = new LatLon(float(stringArray[2]), float(stringArray[3]));
  return(latLon);
}

//Function to get an image from a string query
//ZL = zoom level
PImage getSatImage(String query, int zl) {
  println(query);
  LatLon latLon = getLatLon(query);

  String url = "http://maps.googleapis.com/maps/api/staticmap?center=" + latLon.lon + "," + latLon.lat + "&zoom=" + zl + "&scale=1&size=640x640&maptype=satellite&sensor=false&junk=.jpg"; //the &junk=.jpg at the end is just a string that tricks processing into thinking the file is a jpg

  return(loadImage(url));
}


//Function to get a sequence of directions from Google Directions
XML[] getRoute(LatLon s, LatLon e) {
  
  String endPoint = "http://maps.googleapis.com/maps/api/directions/xml?";
  String url = endPoint + "origin=" + str(s.lat) + "," + str(s.lon) + "&destination=" + str(e.lat) + "," + str(e.lon) + "&sensor=false&mode=walking";
  XML[] legs = null;
  XML xml = new XML(this, url);
  XML bounds = xml.getChild("route/bounds");
  if (!bounded) setBounds(bounds);
  XML route = xml.getChild("route");
  try {
    legs = route.getChildren("leg");
  } 
  catch (Exception ex) {
  }

  return legs;
}

//Functions to draw route
void drawLeg(XML l) {
  XML[] steps = l.getChildren("step");
  for (int i = 0; i < steps.length; i++) {
    drawStep(steps[i]);
  }
}

void drawStep(XML s) {
  PVector start = new PVector();
  PVector end = new PVector();
  start.x = float(s.getChild("start_location/lng").getContent());
  start.y = float(s.getChild("start_location/lat").getContent());

  LatLon sll = new LatLon(start.x, start.y);
  pointList.add(sll);

  end.x = float(s.getChild("end_location/lng").getContent());
  end.y = float(s.getChild("end_location/lat").getContent());

  LatLon ell = new LatLon(end.x, end.y);
  pointList.add(ell);

  float x1 = map(start.x, bottomLeft.x, topRight.x, border, width - border);
  float y1 = map(start.y, topRight.y, bottomLeft.y, border, height - border);

  float x2 = map(end.x, bottomLeft.x, topRight.x, border, width - border);
  float y2 = map(end.y, topRight.y, bottomLeft.y, border, height - border);

  line(x1, y1, x2, y2);
}


//Function to set bounds for route building
void setBounds(XML b) {
  topRight.x = float(b.getChild("southwest/lng").getContent());
  topRight.y = float(b.getChild("southwest/lat").getContent());

  bottomLeft.x = float(b.getChild("northeast/lng").getContent());
  bottomLeft.y = float(b.getChild("northeast/lat").getContent());

  bounded = true;
}

//Generic lat/lon object
class LatLon {
  float lat;
  float lon;
  LatLon(float l, float ln) {
    lat = l;
    lon = ln;
  }
}
