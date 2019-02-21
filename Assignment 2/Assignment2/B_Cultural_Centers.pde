ArrayList<POI> pois;

class POI{
  //coordinate
  PVector coord;
  
  //lat, lon values
  float lat;
  float lon;
  
  //Is Arts Center?
  boolean Arts_Centre;
  
  //Type -- may use later
  String type;
  
  POI(float _lat, float _lon){
  //constructor is a template to make a POI
  lat = _lat;
  lon = _lon;
  coord = new PVector(lat, lon);
  }
  
  void draw(){
    PVector screenLocation = map.getScreenLocation(coord);
    noStroke();
    if(Arts_Centre) fill(arts_centre);
    ellipse(screenLocation.x, screenLocation.y, 6, 6);
  }
}
