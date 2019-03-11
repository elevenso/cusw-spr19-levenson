ArrayList<Polygon> CensusPolygons;
Polygon district;
Polygon households;

class Polygon{
  //Shape, coordinates, and color variables
  PShape p;
  PShape q;
  ArrayList<PVector>coordinates;
  color fill;
  color household_fill;
  float pop;
  int id; 
  float score;
  float household_score;
  String label;
  float[][] scores;
  boolean outline; 
  float coord_x, coord_y;

  //Empty constructor
  Polygon(){
    coordinates = new ArrayList<PVector>();
  }
  
  //Constructor with coordinates
  Polygon(ArrayList<PVector> coords){
    coordinates = coords;
  }
  
  Polygon(ArrayList<PVector> coords, color _c){
    coordinates = coords;
    fill = _c;
  }
  
  void colorByScore(){
    fill = color(255*(score-30)/25); //lighter means older
  }
  
  void colorHouseholdsByScore(){
    household_fill = color(255*(1-household_score)); //darker means more households w/ children
  }
  
  /**void labelLocation(){
     text(label, 0, 0);
  }*/
  
  //Making the shape to draw
  void makeShape(){
    p = createShape();
    p.beginShape();
    p.fill(fill, 200);
    p.stroke(0);
    p.strokeWeight(.5);
    if(outline){
      p.noFill();
      p.stroke(255, 200, 20);
      p.strokeWeight(4);
    }
    for(int i = 0; i<coordinates.size(); i++){
        PVector screenLocation = map.getScreenLocation(coordinates.get(i));
        p.vertex(screenLocation.x, screenLocation.y);
    }
    fill(255, 100, 100);
    p.endShape();
    
    q = createShape();
    q.beginShape();
    q.fill(household_fill, 200);
    println("fill", household_fill);
    println("score", household_score);
    q.stroke(0);
    q.strokeWeight(.5);
    for(int i = 0; i<coordinates.size(); i++){
        PVector screenLocation = map.getScreenLocation(coordinates.get(i));
        q.vertex(screenLocation.x, screenLocation.y);
    }
    fill(255, 100, 100);
    q.endShape();
  }
  

  //Drawing shape
  void draw(){
    if (Show_Median_Age){
      shape(p, 0, 0);
    }
    if (Show_Households){
      shape(q, 0, 0);
    }
    //labelLocation();
  }

  
boolean pointInPolygon(PVector pos) {
    int i, j;
    boolean c=false;
    int sides = coordinates.size();
    for (i=0,j=sides-1;i<sides;j=i++) {
      if (( ((coordinates.get(i).y <= pos.y) && (pos.y < coordinates.get(j).y)) || ((coordinates.get(j).y <= pos.y) && (pos.y < coordinates.get(i).y))) &&
            (pos.x < (coordinates.get(j).x - coordinates.get(i).x) * (pos.y - coordinates.get(i).y) / (coordinates.get(j).y - coordinates.get(i).y) + coordinates.get(i).x)) {
        c = !c;
      }
    }
    return c;
  }
}
