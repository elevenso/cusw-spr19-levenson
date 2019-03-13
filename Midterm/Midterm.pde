MercatorMap map;
PImage background;
//boolean Show_POIs;

void setup(){
  size(1005, 675);
  map = new MercatorMap(width, height, 37.8700300, 37.8686700, -122.2729400, -122.2703600, 0);
  pois = new ArrayList<POI>();
  polygons = new ArrayList<Polygon>();
  loadData();
  parseData();
}

void draw(){
  image(background, 0, 0);
  fill(0, 100);
  rect(0, 0, width, height);
  
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  
  for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }
  
}
