MercatorMap map;
PImage background;
boolean Show_Median_Age;
boolean Show_Households;
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
  
  if(Show_Median_Age){
    for(int i = 0; i<CensusPolygons.size(); i++){
      CensusPolygons.get(i).draw();
    district.draw(); 
    }
  }
  
  if(Show_Households){
    for(int i = 0; i<CensusPolygons.size(); i++){
      CensusPolygons.get(i).draw();
    households.draw(); 
    }
  }
  
  if (Clear){
    Show_Median_Age = false;
    Show_Households = false;
    Clear = false;
  }
  
  fill(178, 24, 81, 185);
  noStroke();
  rect(20, 610, 250, 165);
  textSize(18);
  fill(0);
  text("School Districts", 30, 640);
  text("in the San Francisco", 30, 665);
  text("Bay Area", 30, 690);
  textSize(10);
  text("(Press 'm' for median age", 30, 740);
  text("Press 'h' for households with children/without", 30, 753);
  text("Press 'c' to clear.)", 30, 766);
  if (Show_Households){
    textSize(12);
    text("Darker polygons indicate more" , 30, 710);
    text("households with children.", 30, 725);
  }
  if (Show_Median_Age){
    textSize(12);
    text("Darker polygons indicate lower" , 30, 710);
    text("median age.", 30, 725);
  }
  textSize(10);
  text("Based on 2010 Census Data", 650, 770);
}

void keyPressed(){
  if (key=='m') {
    Show_Median_Age = true;
    Show_Households = false;
  }
  if (key=='h'){
    Show_Households = true;
    Show_Median_Age = false;
  }
  if(key=='c'){
    Clear = true;
  }
}
