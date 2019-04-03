JSONArray features;
JSONObject Park;
boolean Tree_Bool;
boolean Bench_Bool;
PGraphics add_objects;


void loadData(){
  background = loadImage("Civic_Center_Map.png");
  background.resize(width-200, height);
  
  benches = loadImage("bench_image.png");
  benches.resize(20, 15);
  
  trees = loadImage("tree_image.png");
  trees.resize(15, 20); 
  
  Park = loadJSONObject("civic_map.json");
  features = Park.getJSONArray("features");
}

void parseData(){
  
  //create Off Screen graphics (holding layers in "cloud")
  add_objects = createGraphics(width, height);
  
  for (int i=0; i< features.size(); i++){
    //Identify 3: properties, geometry, and type
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
    
    //natural to find trees
    String dataNatural = properties.getJSONObject("tags").getString("natural");
    String natural = properties.getJSONObject("tags").getString("natural");
    if (dataNatural != null) natural = dataNatural;
    else natural = "";
    
    //landuse to find grass
    String dataLanduse = properties.getJSONObject("tags").getString("landuse");
    String landuse = properties.getJSONObject("tags").getString("landuse");
    if (dataLanduse != null) landuse = dataLanduse;
    else landuse = "";
    
    //amenities to find benches
    String dataAmenity = properties.getJSONObject("tags").getString("amenity");
    String amenity = properties.getJSONObject("tags").getString("amenity");
    if (dataAmenity != null) amenity = dataAmenity;
    else amenity = "";
    
    //highway to find footways
    String dataHighway = properties.getJSONObject("tags").getString("highway");
    String highway = properties.getJSONObject("tags").getString("highway");
    if (dataHighway != null) highway = dataHighway;
    else highway = "";
    
    if(type.equals("Point")){
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      
      POI tree = new POI(lat, lon);
      tree.type = natural;
      if(natural.equals("tree")){
        Tree_Bool = true;
        // draw in PGraphics
        add_objects.beginDraw();
        PVector screenLocation_tree = map.getScreenLocation(tree.coord);
        add_objects.image(trees, screenLocation_tree.x, screenLocation_tree.y);
        add_objects.endDraw();
      }
      pois.add(tree);
      
     
      // add to array list
      
      POI bench = new POI(lat, lon);
      bench.type = amenity;
      if(amenity.equals("bench")){
        Bench_Bool = true;
        // draw in PImage
        add_objects.beginDraw();
        PVector screenLocation_bench = map.getScreenLocation(bench.coord);
        add_objects.image(benches, screenLocation_bench.x, screenLocation_bench.y);
        add_objects.endDraw();
      }
      pois.add(bench);

      // add to array list
    }
    
    if(type.equals("Polygon")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      //get the coordinates and iterate through them
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for(int j = 0; j<coordinates.size(); j++){
        float _lat = coordinates.getJSONArray(j).getFloat(1);
        float _lon = coordinates.getJSONArray(j).getFloat(0);
        
        PVector coordinate = new PVector(_lat, _lon);
        coords.add(coordinate);
      }
      Polygon grass = new Polygon(coords);
      grass.type = landuse;
      if(landuse.equals("grass")) grass.Grass_Bool = true;
      polygons.add(grass);
    }
    
    if(type.equals("LineString")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      //get the coordinates and iterate through them
      JSONArray coordinates = geometry.getJSONArray("coordinates");
      for(int j = 0; j<coordinates.size(); j++){
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        //Make a PVector and add it
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      //Create the Way with the coordinate PVectors
      Way footway = new Way(coords);
      footway.type = highway;
      if(highway.equals("footway")) footway.Footway_Bool = true;
      ways.add(footway);
    }
  }
 }    
