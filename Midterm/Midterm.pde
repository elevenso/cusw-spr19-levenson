// CIVIC CENTER PARK, BERKELEY, CA REDESIGN TOOL

MercatorMap map;
PImage background, object;
PFont helvetica, bold;
boolean object_bool, add_bench, add_tree, clear, frame_rate = false, background_bool = true;

//PGraphics add_objects;
int bench_counter = 4;
int tree_counter = 1;

//list to hold all trees and benches currently on map
ArrayList<PVector> object_list = new ArrayList<PVector>();

// A function to contain model initialization
void initModel() {
  
  /* Step 1: Initialize Network */
  waysNetwork(ways);
  
  /* Step 2: Initialize Paths */
  poiPaths(3); // 3 paths PER tree or bench;
  
  /* Step 3: Initialize Population */
  
  //coefficient of paths.size() = starting number of people (if there was one feature to start)
  //initPopulation(5*object_list.size());
  initPopulation(0);
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

}

void draw(){
  background(0);
  
  //background controlled with key 'm'
  if (background_bool) {
    tint(255, 120); // makes background transparent
    image(background, 0, 0);
    tint(255);
  }

  
  // Draw GIS Objects
  for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }
  
  //for (int i =0; i<ways.size(); i++){
  //  ways.get(i).draw();
  //}
  // Drawing the background graph this way is much less "intense"
  tint(255, 100);
  image(network.img, 0, 0);
  tint(255);
  
  
  /*  Displays the path properties.
   *  FORMAT: display(color, alpha)
   */
  for (Path p: paths) {
    p.display(#FFFF00, 50); //bright yellow
  }
  
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  
  /*  Update and Display the population of agents
   *  FORMAT: display(color, alpha)
   */
   
   
  boolean collisionDetection = false;
  for (Agent p: people) {
    p.update(personLocations(people), collisionDetection);
    p.display(#FFFFFF, 200); //white
  }
  
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
  if (clear){
    frame_rate = false;
    object = null;
    add_objects.beginDraw();
    add_objects.clear();
    
    //return original objects
    for (int object=0; object<original_object_list.size()-1; object++){
      add_objects.image(benches, original_object_list.get(object).x, original_object_list.get(object).y);
    }
    add_objects.image(trees, original_object_list.get(4).x, original_object_list.get(4).y);
    add_objects.endDraw();
    
    //removes all old objects from object list
    for (int i = object_list.size()-1; i > 4; i--) {
      object_list.remove(i);
    }
    
    //makes sure number of people reflects number of objects
    bench_counter = 4;
    tree_counter = 1;
    
    //restart model
    initModel();
    clear = false;
  }
  
  //display information about the model on the screen
  drawLegend();
  
  //display frame rate in legend
  if (frame_rate) {
    fill(45);
    text("Frame Rate: " + frameRate, width-180, 450);
  }
}

void keyPressed(){
  if (key == 'b'){
    add_bench = !add_bench;
    add_tree = false;
  } else if (key == 't'){
    add_tree = !add_tree;
    add_bench = false;
  } else if (key == 'c'){
    add_tree = false;
    add_bench = false;
    clear = true;
  } else if (key == 'm'){
    if (background_bool) background_bool = false;
    else background_bool = true;
  } else if (key == 'r') {
    // Regenerate paths if r key is pressed
    initModel();
  } else if (key == 'f') {
    frame_rate = true;
  } else {
    // allows user to press any other key to deselect bench and tree
    add_bench = false;
    add_tree = false;
    object = null;
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
    object_list.add(new PVector(mouseX, mouseY));
  }
  
  if (object == trees) {
    tree_counter+=1;
    object_list.add(new PVector(mouseX, mouseY));
  }
  
  initModel();
  
}
