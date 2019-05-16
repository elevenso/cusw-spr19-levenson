//From Tutorial_4B
//did not include applypackingCourse, cullRandom, packing class

class Node {
  PVector loc;
  int ID;
  int gridX, gridY; 
  
  // Variables to describe relationship to adjacent neighbors
  
  ArrayList<Integer> adj_ID;
  ArrayList<Float> adj_Dist;
  
  Node (float x, float y, float scale) {
    ID = 0;
    
    loc = new PVector(x,y);
    // Neighbor ID in ArrayList<Node>
    adj_ID = new ArrayList<Integer>();
    // Distance to Respective Neighbor in ArrayList<Node>
    adj_Dist = new ArrayList<Float>();
    
    // Variable to describe local grid location for fast computation
    gridX = int(x/scale);
    gridY = int(y/scale);
  }
  
  void addNeighbor(int n, float d) {
    adj_ID.add(n);
    adj_Dist.add(d);
  }
  
  void clearNeighbors() {
    adj_ID.clear();
    adj_Dist.clear();
  }
}

// A network of nodes and edges
//
class Graph {
  
  ArrayList<Node> nodes;
  int U, V;
  float SCALE;
  PGraphics img; // Graph is drawn once into memory
  
  // Using the canvas width and height in pixels, a gridded graph 
  // is generated with a pixel spacing of 'scale'
  
  Graph (int w, int h, float scale) {
    U = int(w/scale);
    V = int(h/scale);
    SCALE = scale;
    img = createGraphics(w, h);
    
    nodes = new ArrayList<Node>();
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        nodes.add(new Node(i*SCALE + scale/2, j*SCALE + scale/2, scale));
      }
    }
    generateEdges();
  }
  // Using the canvas width and height in pixels, a graph is generated using ways
  
  Graph(int w, int h, float scale, ArrayList<Way> ways) {
    SCALE = scale;
    U = int(w / SCALE);
    V = int(h / SCALE);
    img = createGraphics(w, h);
    nodes = new ArrayList<Node>();
    
    int numWays = ways.size();
    for (int i=0; i<numWays; i++) {
      int numNodes = ways.get(i).coordinates.size();
      for (int j=0; j<numNodes; j++) {
        
        float x = ways.get(i).coordinates.get(j).x;
        float y = ways.get(i).coordinates.get(j).y;
        PVector coord = new PVector(x, y);
        PVector screenLocation = map.getScreenLocation(coord);
        Node n = new Node(screenLocation.x, screenLocation.y, scale);
        n.ID = i;
        n.clearNeighbors();
        nodes.add(n);
      }
    }
    // Connect per Object ID
    int objectID, lastID = -1;
    float dist;

    for (int i=0; i<nodes.size(); i++) {
      
      if (i != 0) lastID   = nodes.get(i-1).ID;
      objectID = nodes.get(i).ID;
      if (lastID == objectID) {
        dist = sqrt(sq(nodes.get(i).loc.x - nodes.get(i-1).loc.x) + sq(nodes.get(i).loc.y - nodes.get(i-1).loc.y));
        nodes.get(i).addNeighbor(i-1, dist);
      }
    }
    
    // Add and Connect Intersecting Segments
    ArrayList<Node>[][] bucket = new ArrayList[U][V];
    for (int u=0; u<U; u++) {
      for (int v=0; v<V; v++) {
        bucket[u][v] = new ArrayList<Node>();
      }
    }
    int u, v;
    for (int i=0; i<nodes.size(); i++) {
      nodes.get(i).ID = i;
      u = min(U-1, nodes.get(i).gridX);
      u = max(0,   u);
      v = min(V-1, nodes.get(i).gridY);
      v = max(0,   v);
      bucket[u][v].add(nodes.get(i));
    }
    for (int i=0; i<nodes.size(); i++) {
      u = min(U-1, nodes.get(i).gridX);
      u = max(0,   u);
      v = min(V-1, nodes.get(i).gridY);
      v = max(0,   v);
      ArrayList<Node> nearby = bucket[u][v];
      for (int j=0; j<nearby.size(); j++) {
        dist = abs(nodes.get(i).loc.x - nearby.get(j).loc.x) + abs(nodes.get(i).loc.y - nearby.get(j).loc.y);
        //if (dist < 5) { // distance in canvas pixels
        if (dist == 0) { // distance in canvas pixels
          nodes.get(i).addNeighbor(nearby.get(j).ID, dist);
          nodes.get(nearby.get(j).ID).addNeighbor(i, dist);
        }
      }
    }
    
    render(#FFFF00, 255);
  }
  
  void generateEdges() {
    float dist;
    
    for (int i=0; i<nodes.size(); i++) {
      nodes.get(i).clearNeighbors();
      for (int j=0; j<nodes.size(); j++) {
        dist = sqrt(sq(nodes.get(i).loc.x - nodes.get(j).loc.x) + sq(nodes.get(i).loc.y - nodes.get(j).loc.y));
        
        if (dist < 2*SCALE && dist != 0) {
          nodes.get(i).addNeighbor(j, dist);
        }
      }
    }
    
    render(255, 255);
  }
  
  // Returns the number of neighbors present at a given node index
  
  int getNeighborCount(int i) {
    if (i < nodes.size()) {
      return nodes.get(i).adj_ID.size();
    } else {
      return 0;
    }
  }
  
  // Returns the Array Index of a specific Neighbor
  //
  int getNeighbor (int i, int j) {
    int neighbor = -1;
    
    if (getNeighborCount(i) > 0) {
      neighbor = nodes.get(i).adj_ID.get(j);
    }
    
    return neighbor;
  }
  
  // Returns the Distance of a Specific Neighbor
  //
  float getNeighborDistance (int i, int j) {
    float dist = Float.MAX_VALUE;
    
    if (getNeighborCount(i) > 0) {
      dist = nodes.get(i).adj_Dist.get(j);
    }
    
    return dist;
  }
  
  int getClosestNeighbor(int i) {
    int closest = -1;
    float dist = Float.MAX_VALUE;
    float currentDist;
    
    if (getNeighborCount(i) > 0) {
      for (int j=0; j<getNeighborCount(i); j++) {
        currentDist = nodes.get(i).adj_Dist.get(j);
        if (dist > currentDist) {
          dist = currentDist;
          closest = nodes.get(i).adj_ID.get(j);
        }
      }
    }
    
    return closest;
  }
  
  float getClosestNeighborDistance(int i) {
    float dist = Float.MAX_VALUE;
    int n = getClosestNeighbor(i);
    
    for (int j=0; j<getNeighborCount(i); j++) {
      if (nodes.get(i).adj_ID.get(j) == n) {
        dist = nodes.get(i).adj_Dist.get(j);
      }
    }
    
    return dist;
  }
  
  void render(int col, int alpha) {
    img.beginDraw();
    img.clear();
    
    // Formatting
    
    img.noFill();
    img.stroke(col, alpha);
    img.strokeWeight(10);
    
    
    // Draws Tangent Circles Centered at pathfinding nodes
    //
    Node n;
    for (int i=0; i<nodes.size(); i++) {
      n = nodes.get(i);
      //img.ellipse(n.loc.x, n.loc.y, SCALE, SCALE);
      img.ellipse(n.loc.x, n.loc.y, 3, 3);
    }
    
    
    // Draws Edges that Connect Nodes
    
    int neighbor;
    for (int i=0; i<nodes.size(); i++) {
      for (int j=0; j<nodes.get(i).adj_ID.size(); j++) {
        neighbor = nodes.get(i).adj_ID.get(j);
        img.line(nodes.get(i).loc.x, nodes.get(i).loc.y, nodes.get(neighbor).loc.x, nodes.get(neighbor).loc.y);
      }
    }
    img.endDraw();
  }
}
