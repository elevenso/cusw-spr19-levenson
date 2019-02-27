ArrayList<POI> pois;

class POI{
  //coordinate
  PVector coord;
  
  //lat, lon values
  float lat;
  float lon;
  
  //Is Bus Station?
  boolean Bus_Stop;
  
  //Is Cafe?
  boolean Cafe_Bool;
  
  //Type -- may use later
  String type;
  
  POI(float _lat, float _lon){
  //constructor is a template to make a POI
  lat = _lat;
  lon = _lon;
  coord = new PVector(lat, lon);
  }
  
  void draw() {
    PVector screenLocation = map.getScreenLocation(coord);
    fill(poi_fill);
    noStroke();
    if (Bus_Stop) fill(bus_stop_color);
    ellipse(screenLocation.x, screenLocation.y, 6, 6);
    if (Cafe_Bool) fill(cafe_fill);
    ellipse(screenLocation.x, screenLocation.y, 6, 6);
  }
}
