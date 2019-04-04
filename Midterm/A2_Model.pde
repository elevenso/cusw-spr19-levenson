/* utilizes:
 *  PATHFINDER AND NETWORK ALGORITHMS
 *  Ira Winder, ira@mit.edu
 *  Nina Lutz, nlutz@mit.edu
 *  Coded w/ Processing 3 (Java)
 *
 *  The Main Tab "Tutoiral_3A_Agents" shows an example implementation of 
 *  algorithms useful for finding shortest pathes snapped to a gridded or OSM-based 
 *  network. Explore the various tabs to see how they work.
 *
 *  CLASSES CONTAINED:
 *
 *    Pathfinder() - Method to calculate shortest path between to nodes in a graph/network
 *    Graph() - Network of nodes and wighted edges
 *    Node() - Fundamental building block of Graph()
 *    ObstacleCourse() - Contains multiple Obstacles; Allows editing, saving, and loading of configuration
 *    Obstacle() - 2D polygon that can detect overlap events
 *    MercatorMap() - translate lat-lon to screen coordinates
 *    
 *    Standard GIS shapes:
 *    POI() - i.e. points, representing points of interest, etc
 *    Way() - i.e. lines, representing streets, paths, etc
 *    Polygons() - representing buildings, parcels, etc
 *
 *  FUNDAMENTAL OUTPUT: 
 *
 *    ArrayList<PVector> shortestPath = Pathfinder.findPath(PVector A, PVector B, boolean enable)
 *
 *  CLASS DEPENDENCY TREE: 
 *
 *
 *     POI() / Way()  ->  Node()  ->      Graph()        ->      Pathfinder()  ->  OUTPUT: ArrayList<PVector> shortestPath
 *
 *                                            ^                                        |
 *                                            |                                        v
 *
 *     Polygon()  ->  Obstacle()  ->  ObstacleCourse()                             Agent()                                   
 *
 */
 //From Tutorial_4B

// Objects to define our Network
//
ObstacleCourse course;
Graph network;
Pathfinder finder;

//  Object to define and capture a specific origin, destiantion, and path
ArrayList<Path> paths;

//  Objects to define agents that navigate our environment
ArrayList<Agent> people;

void randomNetwork(float cull) {
  //  An example gridded network of width x height (pixels) and node resolution (pixels)
  //
  int nodeResolution = 10;  // pixels
  int graphWidth = width;   // pixels
  int graphHeight = height; // pixels
  network = new Graph(graphWidth, graphHeight, nodeResolution);
  network.cullRandom(cull); // Randomly eliminates a fraction of the nodes in the network (0.0 - 1.0)
}

void randomNetworkMinusBuildings(float cull, ArrayList<Polygon> poly) {
  //  An example gridded network of width x height (pixels) and node resolution (pixels)
  //
  int nodeResolution = 10;  // pixels
  int graphWidth = width;   // pixels
  int graphHeight = height; // pixels
  network = new Graph(graphWidth, graphHeight, nodeResolution);
  
  // An obstacle Course Based Upon Building Footprints
  //
  course = new ObstacleCourse();
  for (Polygon p: poly) {
    int numCorners = p.coordinates.size();
    PVector[] corners = new PVector[numCorners];
    for (int i=0; i<numCorners; i++) {
      PVector screenLocation = map.getScreenLocation(p.coordinates.get(i));
      corners[i] = new PVector(screenLocation.x, screenLocation.y);
    }
    Obstacle o = new Obstacle(corners);
    course.addObstacle(o);
  }
  
  // Subtract Building Footprints from Network
  //
  network.cullRandom(cull); // Randomly eliminates a fraction of the nodes in the network (0.0 - 1.0)
  network.applyObstacleCourse(course);
  
}

void waysNetwork(ArrayList<Way> w) {
  //  An example gridded network of width x height (pixels) and node resolution (pixels)
  //
  int nodeResolution = 10;  // pixels
  int graphWidth = width;   // pixels
  int graphHeight = height; // pixels
  network = new Graph(graphWidth, graphHeight, nodeResolution, w);
}

void randomPaths(int numPaths) {
  /*  An pathfinder object used to derive the shortest path. */
  finder = new Pathfinder(network);
  
  /*  Generate List of Shortest Paths through our network
   *  FORMAT 1: Path(float x, float y, float l, float w) <- defines 2 random points inside a rectangle
   *  FORMAT 2: Path(PVector o, PVector d) <- defined by two specific coordinates
   */
   
  paths = new ArrayList<Path>();
  for (int i=0; i<numPaths; i++) {
    //  An example Origin and Desination between which we want to know the shortest path
    //
    PVector orig = new PVector(random(1.0)*width, random(1.0)*height);
    PVector dest = new PVector(random(1.0)*width, random(1.0)*height);
    Path p = new Path(orig, dest);
    p.solve(finder);
    paths.add(p);
  }
  
}

void poiPaths(int numPaths) {
  /*  An pathfinder object used to derive the shortest path. */
  finder = new Pathfinder(network);
  
  /*  Generate List of Shortest Paths through our network
   *  FORMAT 1: Path(float x, float y, float l, float w) <- defines 2 random points inside a rectangle
   *  FORMAT 2: Path(PVector o, PVector d) <- defined by two specific coordinates
   */
   
  paths = new ArrayList<Path>();
  for (int i=0; i<numPaths; i++) { //make numPaths 5*(number trees+benches), could be random, use ArrayList.size()
    
    // Searches for valid paths only
    boolean notFound = true;
    while(notFound) {
      //  An example Origin and Desination between which we want to know the shortest path
      //
      // Origin is Random POI //can draw POI origins
      int orig_index = int(random(pois.size()));
      PVector orig = pois.get(orig_index).coord;
      orig = map.getScreenLocation(orig);
      
      // make destinations benches, trees instead of random
      int dest_index = int(random(object_list.size()));
      PVector dest = object_list.get(dest_index);
      
      Path p = new Path(orig, dest);
      p.solve(finder);
      
      if(p.waypoints.size() > 1) {
        notFound = false;
        paths.add(p);
      }
      
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
  
  //println("initial count:" + new_count);
  
  for (int j = 0; j < bench_counter; j++) {
    new_count += 2;
    // * println("bench adding count: " + new_count);
  }
  
  for (int k = 0; k < tree_counter; k++) {
    new_count += 1;
    // * println("tree adding count: " + new_count);
  }
  
  //add agents
  for (int i = 0; i < new_count; i++) {
    // * get all paths
    // for (int j = 0; j < paths.size(); j++) {
      // Path random_path = paths.get(j);
    // * picks a random number to index from length of paths
     int random_index = int(random(paths.size()));
    // * gets random path from list of paths with index
     Path random_path = paths.get(random_index);
      if (random_path.waypoints.size() > 1) {
        int random_waypoint = int(random(random_path.waypoints.size()));
        float random_speed = random(0.1, 0.3);
        PVector loc = random_path.waypoints.get(random_waypoint);
        Agent person = new Agent(loc.x, loc.y, 9, random_speed, random_path.waypoints);
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
