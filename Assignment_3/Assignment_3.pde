MercatorMap map;
PImage background;
boolean Show_Schools;
boolean Clear;

void setup(){
  CensusPolygons = new ArrayList<Polygon>();
  size(800, 800);
  frameRate(40);
  //Intiailize your data structures early in setup 
  map = new MercatorMap(width, height, 38.346, 37.221, -122.797, -121.668, 0);
  loadData();
  parseData();
}

void draw(){
  image(background, 0, 0);
  fill(0, 120);
  rect(0, 0, width, height);
  
  keyPressed();
  
  if(Show_Schools){
    for(int i = 0; i<CensusPolygons.size(); i++){
      CensusPolygons.get(i).draw();
    district.draw(); 
  }
  }
  
  if (Clear){
    Show_Schools = false;
    Clear = false;
  }
  
  fill(178, 24, 81, 185);
  noStroke();
  rect(20, 620, 200, 155);
  textSize(18);
  fill(0);
  text("School Districts", 30, 650);
  text("in the San Francisco", 30, 675);
  text("Bay Area", 30, 700);
  textSize(12);
  text("Lighter polygons indicate" , 30, 735);
  text("higher median age.", 30, 755);
  textSize(8);
  text("(Press any key to view data", 30, 770);
  text("Press 'c' to clear.)", 30, 780);
  
}

void keyPressed(){
  if (keyPressed) {
    Show_Schools = true;
  }
  if(key=='c'){
    Clear = true;
  }
}
