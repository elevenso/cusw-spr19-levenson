ArrayList<Way> ways;

class Way{
  //Coordinates and color variables
  ArrayList<PVector>coordinates;
  
  String type;
  
  //Empty constructor
  Way(){}
  
  //Constructor of coordinates
  Way(ArrayList<PVector> coords){
    coordinates =  coords;
  }
  
  //Draw the road
  void draw(){
    strokeWeight(7);
    stroke(180, 200);
    for(int i = 0; i<coordinates.size()-1; i++){
       //iterate through the coordinates and draw lines
       PVector screenStart = map.getScreenLocation(coordinates.get(i));
       PVector screenEnd = map.getScreenLocation(coordinates.get(i+1));
       line(screenStart.x, screenStart.y, screenEnd.x, screenEnd.y);
     }
  }
}
