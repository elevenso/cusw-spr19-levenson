ArrayList<POI> pois;

class POI{
  //coordinate
  PVector coord;
  
  //lat, lon values
  float lat;
  float lon;
  
  //Is Cafe?
  boolean Cafe_Bool;
  
  //Is Restaurant?
  boolean Restaurant_Bool;
  
  boolean Transport_Bool;
  
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
    //fill(poi_fill);
    //ellipse(screenLocation.x, screenLocation.y, 6, 6);
    noStroke();
    if (Cafe_Bool) {
      fill(cafe_fill);
      ellipse(screenLocation.x, screenLocation.y, 10, 10);
    }
    if (Restaurant_Bool) {
      fill(restaurant_fill);
      ellipse(screenLocation.x, screenLocation.y, 10, 10);
    }
    if (Transport_Bool) {
      fill(transport_fill);
      ellipse(screenLocation.x, screenLocation.y, 6, 6);
    }
  }
}
