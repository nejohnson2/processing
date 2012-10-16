void setup(){
  size(800,600);
  smooth();
  background();
  loadGeo(); 
}

void draw(){
  
}

void loadGeo(){
  // import csv
  String[] input = loadStrings("openpaths_house.csv");
  
   //start loop at one to avoid using the header in the csv file
  for(int i = 1; i< input.length; i++){
   //make a new geopiont
     GeoPoint gp = new GeoPoint();
     String[] splits = input[i].split(",");
     gp.lat = 0;
  }
}
class GeoPoin{
 float lat;
 float lon;
 
 Date theDate;
  
}

