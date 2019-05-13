// REVISED CIVIC CENTER PARK, BERKELEY, CA REDESIGN TOOL
//IMPLEMENT SLIDERS FOR NUMBER OF PEOPLE, SPACE USED
//initialize variables
MercatorMap map;
PFont helvetica, bold;
boolean object_bool, add_bench, add_tree, clear, frame_rate = false, background_bool = true, clicked = false;

//PGraphics add_objects;
int bench_counter = 4;
int tree_counter = 1;

void setup() {
  size(1326, 743);
  map = new MercatorMap(width-200, height, 37.8700300, 37.8686700, -122.2729400, -122.2703600, 0);
  pois = new ArrayList<POI>();
  ways = new ArrayList<Way>();
  loadData();
  parseData();
  
  // establish font, true turns on anti-aliasing (removes jagged edges)
  helvetica = createFont("Helvetica", 16, true); 
  bold = createFont("Helvetica-Bold", 16, true);
  // print(PFont.list()); //uncomment for list of all available fonts
  
  //initialize buttons
  infoX = width-153;
  infoY = height-60;
  warningX = width-103;
  warningY = height-60;
  playX = width-53;
  playY = height-60;
  
  //initialize model
  initModel();
}

void draw() {
  
  //background controlled with key 'm' for now, later make it click button
  background(0);
  if (background_bool) {
    tint(255, 120); // makes background transparent
    image(background, 0, 0);
    tint(255); //stops objects from being tinted too
  }
  
  //draw GIS objects
  for (int i =0; i<ways.size(); i++){
    ways.get(i).draw();
  }
  
  for (int i =0; i<pois.size(); i++){
    pois.get(i).draw();
  }
  
  if (playOver){
    /*// Drawing the background graph this way is much less "intense"
      tint(255, 100);
      image(network.img, 0, 0);
      tint(255);*/
  
      /*  Displays the path properties.
       *  FORMAT: display(color, alpha)
       */
      /*for (Path p: paths) {
        p.display(#FFFF00, 50); //bright yellow
      }
      */
      /*  Update and Display the population of agents
       *  FORMAT: display(color, alpha)
       */
   
   
      boolean collisionDetection = false;
      for (Agent p: people) {
        p.update(personLocations(people), collisionDetection);
        p.display(#FFFFFF, 200); //white
      }
  }
  
  //draw object layers on visible canvas in top left corner (origin)
  image(add_objects, 0, 0); 
  //display information about the model on the screen
  drawLegend();
  image(information, 0, 0);
  
  //allows user to add a bench to map with a click
  if (add_bench){
    object_bool = add_bench;
    image(object, mouseX, mouseY);
  }
  
  //allows user to add a tree to map with a click
  if (add_tree){
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
    for (int object=0; object<original_object_list.size(); object++){
      add_objects.image(benches, original_object_list.get(object).x, original_object_list.get(object).y);
    }
    add_objects.endDraw();
    
    //I THINK THIS DOESN'T NECCESSARILY REMOVE OLD OBJECTS - JUST REMOVES ALL EXCEPT FOUR
     //removes all old objects from object list
    for (int i = object_list.size()-1; i > 4; i--) {
      object_list.remove(i);
    }
    
    //makes sure number of people reflects number of objects
    bench_counter = 4;
    tree_counter = 0;
    
    //restart model
    initModel();
    clear = false;
  }
  
  
  if (frame_rate == true & infoOver == false & warningOver == false) {
    textSize(16);
    fill(45);
     text("Frame Rate: " + frameRate, width-180, 410);
  }
  
}

void keyPressed(){
  if (key == 'b'){
    add_bench = true;
    add_tree = false;
    object = benches;
  } else if (key == 't'){
    add_tree = true;
    add_bench = false;
    object = trees;
  } else if (key == 'c'){
    add_tree = false;
    add_bench = false;
    clear = true;
  } else if (key == 'm'){
    if (background_bool) background_bool = false;
    else background_bool = true;
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
  if (overPlay(playX, playY, circleSize)){
    clicked = true;
  }
  initModel();
}
