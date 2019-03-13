ArrayList<POI> pois;

class POI{
  //coordinate
  PVector coord;
  
  //lat, lon values
  float lat;
  float lon;
  
  boolean Tree_Bool;
  
  String type;
  
  POI(float _lat, float _lon){
  //constructor is a template to make a POI
  lat = _lat;
  lon = _lon;
  coord = new PVector(lat, lon);
  }
  
  void draw() {
    PVector screenLocation = map.getScreenLocation(coord);
    noStroke();
    if (Tree_Bool) {
      fill(tree_color);
      circle(screenLocation.x, screenLocation.y, 10);
    }
  }
}
