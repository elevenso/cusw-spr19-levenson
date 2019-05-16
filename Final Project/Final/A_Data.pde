//initialize variables
  PImage background, object, benches, trees, stars;
  JSONObject park;
  JSONArray features;
  PGraphics add_objects, information;

//list to hold all trees and benches currently on map
  ArrayList<PVector> object_list = new ArrayList<PVector>();
//seperate list so original objects are always on map
  ArrayList<PVector> original_object_list = new ArrayList<PVector>();

/* VARIABLE REFERENCE:
  benches: bench image
  bench: POI variable for bench
  trees: tree image
  tree: POI variable for tree*/

void loadData(){
  
  //load images
  background = loadImage("Civic_Center_Image.png");
  background.resize(width-200, height);
  
  benches = loadImage("bench_image.png");
  benches.resize(30, 22);
  
  trees = loadImage("tree_image.png");
  trees.resize(30, 42);
  
  park = loadJSONObject("civic_map.json");
  features = park.getJSONArray("features");
  
  stars = loadImage("star.png");
  stars.resize(30, 30);
}

void parseData(){
  //create off screen graphics (holding layers in "cloud")
  add_objects = createGraphics(width, height);
  information = createGraphics(width, height);
  
  for (int i=0; i< features.size(); i++){
    //Identify properties, geometry, and type
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
  
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
    
    //landuse to find grass
    String dataLanduse = properties.getJSONObject("tags").getString("landuse");
    String landuse = properties.getJSONObject("tags").getString("landuse");
    if (dataLanduse != null) landuse = dataLanduse;
    else landuse = "";
    
    if(type.equals("Point")){
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      
      //add benches to objects
      POI bench = new POI(lat, lon);
      bench.type = amenity;
      
      if(amenity.equals("bench")){
        // draw in PImage
        add_objects.beginDraw();
        PVector screenLocation_bench = map.getScreenLocation(bench.coord);
        add_objects.image(benches, screenLocation_bench.x, screenLocation_bench.y);
        add_objects.endDraw();
        original_object_list.add(map.getScreenLocation(bench.coord));
        object_list.add(map.getScreenLocation(bench.coord));
      }
      pois.add(bench);
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
      if(landuse.equals("grass")) {
        grass.Grass_Bool = true;
        polygons.add(grass);
      }
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
      ways.add(footway);
    }
    
  }
}
