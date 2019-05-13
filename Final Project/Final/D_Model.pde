/* utilizes:
 *  PATHFINDER AND NETWORK ALGORITHMS
 *  Ira Winder, ira@mit.edu
 *  Nina Lutz, nlutz@mit.edu
 *  Coded w/ Processing 3 (Java)
 */
 
 //removed loops that change size of pop with addition of objects

Graph network;
Pathfinder finder;

//  Object to define and capture a specific origin, destination, and path
ArrayList<Path> paths;

//  Objects to define agents that navigate our environment
ArrayList<Agent> people;

void initModel() {
  
  // Initialize graph network
  waysNetwork(ways);
  
  //Initialize paths
  poiPaths(3); //3 paths PER tree or bench;
  
  //Initialize population
  initPopulation(10);
  
}

void waysNetwork(ArrayList<Way> w) {
  //  An example gridded network of width x height (pixels) and node resolution (pixels)
  
  int nodeResolution = 10;  // pixels
  int graphWidth = width;   // pixels
  int graphHeight = height; // pixels
  network = new Graph(graphWidth, graphHeight, nodeResolution, w);
}

void poiPaths(int numPaths) {
  /*  An pathfinder object used to derive the shortest path. */
  finder = new Pathfinder(network);
  
  /*  Generate List of Shortest Paths through our network
   *  FORMAT 1: Path(float x, float y, float l, float w) <- defines 2 random points inside a rectangle
   *  FORMAT 2: Path(PVector o, PVector d) <- defined by two specific coordinates
   */
   
  paths = new ArrayList<Path>();
  for (int j=0; j<object_list.size(); j++) {
    
    for (int i=0; i<numPaths; i++) { //make numPaths for each tree and bench (numPaths*(tree+bench), pois are random but benches and trees are not, use ArrayList.size()
      
      // Searches for valid paths only
      boolean notFound = true;
      //while(notFound) { // Network file is not universally navigatable, so this prevents infinite loop!
        //  An example Origin and Desination between which we want to know the shortest path
        //
        // Origin is Random POI //can draw POI origins
        int orig_index = int(random(pois.size()));
        PVector orig = pois.get(orig_index).coord;
        orig = map.getScreenLocation(orig);
        
        // make destinations benches, trees instead of random
        //int dest_index = int(random(object_list.size()));
        //PVector dest = object_list.get(dest_index);
        PVector dest = object_list.get(j);
        
        Path p = new Path(orig, dest);
        p.solve(finder);
        
        if(p.waypoints.size() > 1) {
          notFound = false;
          paths.add(p);
        }
        
      //}
      
    }
    
  }
  
}

void initPopulation(int count) {
  /*  An example population that traverses along various paths
  *  FORMAT: Agent(x, y, radius, speed, path);
  */
  people = new ArrayList<Agent>();
  // each bench adds two people, each tree adds 1
  int new_count = count;
  
  int scaler = 3; // amount to multiply people counter per bench/tree
  
  for (int j = 0; j < bench_counter; j++) {
    new_count += 2*scaler;
  }
  
  for (int k = 0; k < tree_counter; k++) {
    new_count += 1*scaler;
  }
  
  //add agents
  for (int i = 0; i < new_count; i++) {
      // Path random_path = paths.get(j);
    // * picks a random number to index from length of paths
     int random_index = int(random(paths.size()));
    // * gets random path from list of paths with index
     Path random_path = paths.get(random_index);
      if (random_path.waypoints.size() > 1) {
        int random_waypoint = int(random(random_path.waypoints.size()));
        float random_speed = random(0.1, 0.3);
        PVector loc = random_path.waypoints.get(random_waypoint);
        Agent person = new Agent(loc.x, loc.y, 8, random_speed, random_path.waypoints);
        people.add(person);
      }
    //}
  }
  //reset count for next initialization, considering benches
  new_count = count;
  println("people: " + people.size());
}

ArrayList<PVector> personLocations(ArrayList<Agent> people) {
  ArrayList<PVector> l = new ArrayList<PVector>();
  for (Agent a: people) {
    l.add(a.location);
  }
  return l;
}
