ArrayList<Polygon> polygons;

class Polygon{
  
  PShape p;
  ArrayList<PVector>coordinates;
  
  boolean Grass_Bool;
  
  String type;

  Polygon(){
    coordinates = new ArrayList<PVector>();
  }
  
  //Constructor with coordinates
  Polygon(ArrayList<PVector> coords){
    coordinates = coords;
    makeShape();
  }
  
  void makeShape(){
    p = createShape();
    p.beginShape();
    p.fill(grass_color, 150);
    p.noStroke();
    //p.strokeWeight(3);
    //p.stroke(grass_border);
    for(int i = 0; i<coordinates.size(); i++){
        PVector screenLocation = map.getScreenLocation(coordinates.get(i));
        p.vertex(screenLocation.x, screenLocation.y);
    }
    p.endShape();
  }

  
  void draw(){
    if(Grass_Bool){
      shape(p, 0, 0);
    }
  }
}
