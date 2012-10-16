ArrayList<LatLon> pointList = new ArrayList();
String query = "New York City";
int zl = 2;

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
 
  return(img = loadImage(url));
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
