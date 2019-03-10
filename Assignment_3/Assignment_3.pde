MercatorMap map;


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
  background(0);
  for(int i = 0; i<CensusPolygons.size(); i++){
    CensusPolygons.get(i).draw();
  }
  district.draw();
}
