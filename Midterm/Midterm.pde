MercatorMap map;
PImage background;
PFont helvetica;
PFont bold;
//boolean Show_POIs;

void setup(){
  size(1205, 675);
  map = new MercatorMap(width-200, height, 37.8700300, 37.8686700, -122.2729400, -122.2703600, 0);
  pois = new ArrayList<POI>();
  polygons = new ArrayList<Polygon>();
  ways = new ArrayList<Way>();
  loadData();
  parseData();
  // establish font, true turns on anti-aliasing (removes jagged edges)
  helvetica = createFont("Helvetica", 16, true); 
  bold = createFont("Helvetica-Bold", 16, true);
  // print(PFont.list()); //uncomment for list of all available fonts
}

void draw(){
  fill(100);
  rect(width-200, 0, 200, height);
  image(background, 0, 0);
  fill(0, 100);
  rect(0, 0, width-200, height);
  
  for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }
  
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  
  /**for (int i =0; i<ways.size(); i++){
    ways.get(i).draw();
  }*/
  
  drawLegend();
  drawInformation();
  
}
