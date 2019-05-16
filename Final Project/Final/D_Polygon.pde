ArrayList<Polygon> polygons;
ArrayList<PVector> vertices;
ArrayList<PVector> screen_vertices;
float area = 0;

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
    p.fill(color(153, 230, 153));
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

void area(){
    /*for (int i =0; i<polygons.get(3).coordinates.size(); i++){
     println(polygons.get(3).coordinates);
     }*/
    vertices = (polygons.get(3).coordinates);
    screen_vertices= new ArrayList<PVector>();
    for(int i = 0; i<polygons.get(3).coordinates.size(); i++){
      PVector screenLocation = map.getScreenLocation(polygons.get(3).coordinates.get(i));
      screen_vertices.add(screenLocation);
    }
    for (int i = 1; i<(screen_vertices.size()-1); i++) {
       area += (screen_vertices.get(i).x * screen_vertices.get(i-1).y - screen_vertices.get(i).y*screen_vertices.get(i-1).x);
    }
    println("area: " + area/2);
  }
