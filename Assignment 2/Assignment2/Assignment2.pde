/*
Template for Assignment 2 for 11.S195 Spring 2019 
Nina Lutz, nlutz@mit.edu 

This template is just a suggested structure but feel free to modify it, use code from class, etc
*/

//blank map
MercatorMap map;
PImage background;
boolean Show_POIs;

void setup(){
size(1000, 650);
  
  //Intiailize your data structures early in setup 
  //Bounding box: min and max longitudes and latitudes of location
  map = new MercatorMap(width, height, 37.87040, 37.86469, -122.27351, -122.26449, 0);
  pois = new ArrayList<POI>();
  loadData();
  parseData();
  
}

void draw(){
  image(background, 0, 0);
  //drawing tint over image
  fill(0, 120);
  rect(0, 0, width, height);
  
  keyTyped();
  if (Show_POIs){
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  }
  
  if (keyPressed) {
    image(background,0,0);
    fill(0, 120);
    rect(0, 0, width, height);
  }
  
  /**for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }*/
  
  drawInfo();
  
}

void keyTyped(){
  if (key=='c') {
    Show_POIs = true;
  }
}
