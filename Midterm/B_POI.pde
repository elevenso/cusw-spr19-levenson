ArrayList<POI> pois;
PImage benches, trees;

class POI{
  //coordinate
  PVector coord;
  
  //lat, lon values
  float lat;
  float lon;
  
  String type;
  
  POI(float _lat, float _lon){
  //constructor is a template to make a POI
  lat = _lat;
  lon = _lon;
  coord = new PVector(lat, lon);
  }
  
  /*void draw() {
    PVector screenLocation = map.getScreenLocation(coord);
    noStroke();
    if (Tree_Bool) {
      strokeWeight(3);
      stroke(tree_border);
      fill(tree_color);
      circle(screenLocation.x, screenLocation.y, 10);
      image(trees, screenLocation.x, screenLocation.y);
      // add to array list
    }
    if (Bench_Bool) {
      image(benches, screenLocation.x, screenLocation.y);
      // add to array list
    }
  }*/
}
