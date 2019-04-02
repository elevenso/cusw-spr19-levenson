// Next steps: add agents

MercatorMap map;
PImage background, object;
PFont helvetica;
PFont bold;
boolean object_bool, add_bench, add_tree, clear;
PGraphics add_objects;
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
  
  //create Off Screen graphics (holding layers in "cloud")
  add_objects = createGraphics(width, height);
}

void draw(){
  fill(150);
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
  
  //draw layers on visible canvas in top left corner (origin)
  image(add_objects, 0, 0); //
  
  if (add_bench){
    object = benches;
    object_bool = add_bench;
    image(object, mouseX, mouseY);
  }
  
  if (add_tree){
    object = trees;
    object_bool = add_tree;
    image(object, mouseX, mouseY);
  }
  
  if(clear){
    add_objects.beginDraw();
    add_objects.clear();
    add_objects.endDraw();
    clear = false;
  }
  
}

void keyPressed(){
  if (key == 'b'){
    add_bench = true;
    add_tree = false;
  }
  
  if (key == 't'){
    add_tree = true;
    add_bench = false;
  }
  
  if (key == 'c'){
    add_tree = false;
    add_bench = false;
    clear = true;
  }
  
}

void mouseClicked(){
  add_objects.beginDraw(); //add objects on layer off screen
  if (object != null){
    add_objects.image(object, mouseX, mouseY);
    object_bool = false;
  }
  add_objects.endDraw(); //stop drawing on layer
}
