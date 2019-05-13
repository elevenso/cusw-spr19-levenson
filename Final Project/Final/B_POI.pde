ArrayList<POI> pois;

class POI{
  //coordinates in a single PVector
  PVector coord;
  
  //lat, lon values
  float lat;
  float lon;
  
  //string variable within class to parse POIs
  String type;
  
  POI(float _lat, float _lon){
  //constructor is a template to make a POI
  lat = _lat;
  lon = _lon;
  coord = new PVector(lat, lon);
  }
  
  void draw() {
    //draw points of interest
    PVector screenLocation = map.getScreenLocation(coord);
    image(stars, screenLocation.x, screenLocation.y);
  }
}
