/*
Template for Assignment 2 for 11.S195 Spring 2019 
Nina Lutz, nlutz@mit.edu 

This template is just a suggested structure but feel free to modify it, use code from class, etc
*/

//blank map
MercatorMap map;
PImage background;
boolean Show_POIs;
boolean Show_Polygons;
boolean Show_Ways;
boolean Clear;

void setup(){
size(1000, 650);
  
  //Intiailize your data structures early in setup 
  //Bounding box: min and max longitudes and latitudes of location
  map = new MercatorMap(width, height, 37.87040, 37.86469, -122.27351, -122.26449, 0);
  pois = new ArrayList<POI>();
  polygons = new ArrayList<Polygon>();
  ways = new ArrayList<Way>();
  loadData();
  parseData();
  
}

void draw(){
  image(background, 0, 0);
  //drawing tint over image
  fill(0, 120);
  rect(0, 0, width, height);

  keyTyped();
  
  //press 'b' to see buildings
  if(Show_Polygons){
  for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }
  }
  //press 'r' to see roads
  if(Show_Ways){
  for(int i = 0; i<ways.size(); i++){
    ways.get(i).draw();
  }
  }
  //press 'p' to see selected points of interest
  if (Show_POIs){
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  }
  //press 'c' to clear graphics
  if (Clear){
    Show_Ways = false;
    Show_Polygons = false;
    Show_POIs = false;
    Clear = false;
  }
 
  //hold any other key to see the blank map
  if (keyPressed) {
    image(background,0,0);
    fill(0, 120);
    rect(0, 0, width, height);
  }
  
  drawInfo();

}

void keyTyped(){
  if (key=='p') {
    Show_POIs = true;
  }
  if (key=='b') {
    Show_Polygons = true;
  }
  if (key=='r') {
    Show_Ways = true;
  }
  if (key=='c') {
    Clear = true;
  }
}
