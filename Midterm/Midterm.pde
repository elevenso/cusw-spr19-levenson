// CIVIC CENTER PARK, BERKELEY, CA REDESIGN TOOL

MercatorMap map;
PImage background, object;
PFont helvetica;
PFont bold;
boolean object_bool, add_bench, add_tree, clear;
PGraphics add_objects;
int bench_counter = 4;
int tree_counter = 1;
//boolean Show_POIs;

// A function to contain model initialization
void initModel() {
  
  /* Step 1: Initialize Network Using ONLY ONE of these methods */
  //randomNetwork(0.5); // a number between 0.0 and 1.0 specifies how 'porous' the network is
  waysNetwork(ways);
  //randomNetworkMinusBuildings(0.1, polygons); // a number between 0.0 and 1.0 specifies how 'porous' the network is
  
  /* Step 2: Initialize Paths Using ONLY ONE of these methods */
  //randomPaths(1);
  poiPaths(1);
  
  /* Step 3: Initialize Population */
  
  //coefficient of paths.size() = starting number of people (if there were no trees/benches to start)
  initPopulation(5*paths.size());
}


void setup(){
  size(1205, 675);
  map = new MercatorMap(width-200, height, 37.8700300, 37.8686700, -122.2729400, -122.2703600, 0);
  pois = new ArrayList<POI>();
  polygons = new ArrayList<Polygon>();
  ways = new ArrayList<Way>();
  loadData();
  parseData();
  
  /* Initialize our model and simulation */
  initModel();
  
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
  
  // Draw GIS Objects
  for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }
  
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  
  /* for (int i =0; i<ways.size(); i++){
    ways.get(i).draw();
  }*/
  
  /*  Displays the path properties.
   *  FORMAT: display(color, alpha)
   */
  for (Path p: paths) {
    p.display(100, 100);
  }
  
  /*  Update and Display the population of agents
   *  FORMAT: display(color, alpha)
   */
  boolean collisionDetection = true;
  for (Agent p: people) {
    p.update(personLocations(people), collisionDetection);
    p.display(#FFFFFF, 255);
  }
  
  //display information about the model on the screen
  drawLegend();
  drawInformation();
  
  //draw object layers on visible canvas in top left corner (origin)
  image(add_objects, 0, 0); //
  
  //allows user to add a bench to map with a click
  if (add_bench){
    object = benches;
    object_bool = add_bench;
    image(object, mouseX, mouseY);
  }
  
  //allows user to add a tree to map with a click
  if (add_tree){
    object = trees;
    object_bool = add_tree;
    image(object, mouseX, mouseY);
  }
  
  //clears benches, trees
  if(clear){
    add_objects.beginDraw();
    add_objects.clear();
    add_objects.endDraw();
    clear = false;
    bench_counter = 4;
    tree_counter = 1;
    initModel();
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
  
  if(key == 'i'){
    initModel();
}
  
}

void mouseClicked(){
  add_objects.beginDraw(); //add objects on layer off screen
  if (object != null){
    add_objects.image(object, mouseX, mouseY);
    object_bool = false;
  }
  add_objects.endDraw(); //stop drawing on layer
  
  //change number of people based on benches, trees
  if (object == benches) {
    bench_counter+=1;
  }
  
  if (object == trees) {
    tree_counter+=1;
  }
  
  initModel();
  
}
