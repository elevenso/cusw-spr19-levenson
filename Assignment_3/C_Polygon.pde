ArrayList<Polygon> CensusPolygons;
Polygon district;

class Polygon{
  //Shape, coordinates, and color variables
  PShape p;
  ArrayList<PVector>coordinates;
  color fill;
  float pop;
  int id; 
  float score;
  float[][] scores;
  boolean outline; 

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
  
  //void normalizeScores(){
    //float min = 1000000;
    //float max = 0;
    //float val = _score;
    //if (val < min) min = val;
    //if (val > max) max = val;
  //}
  
  void colorByScore(){
    //int cellX, cellY;
    //float[][] _scores;
    //color worst, mid, best;
 
      //worst = color(200, 0, 0);
      //mid = color(255, 255, 0);
      //best = color(0, 200, 0);
      //scores = new float[cellX][cellY];
    
    /**for(int i = 0; i<numX; i++){
      for(int j = 0; j<numY; j++){
        color col = color(0, 0, 0);
        float val = _scores[i][j];
        if(val*255/56000 < 50) col = lerpColor(worst, mid, val/100); //convert data to color
        if(val*255/56000 == 50) col = mid;
        if(val*255/56000 > 50) col = lerpColor(mid, best, val/100);
        fill = color(col);
      }
    }*/
    fill = color(score);
  }
  
  //Making the shape to draw
  void makeShape(){
    p = createShape();
    p.beginShape();
    p.fill(fill);
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
    p.endShape();
  }
  

  //Drawing shape
  void draw(){
    shape(p, 0, 0);
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
