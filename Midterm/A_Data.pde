JSONArray features;
JSONObject Park;


void loadData(){
  background = loadImage("Civic_Center_Map.png");
  background.resize(width-200, height);
  
  Park = loadJSONObject("civic_map.json");
  features = Park.getJSONArray("features");
}

void parseData(){
  
  for (int i=0; i< features.size(); i++){
    //Identify 3: properties, geometry, and type
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
    
    //natural to find grass
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
    
    if(type.equals("Point")){
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      
      POI tree = new POI(lat, lon);
      tree.type = natural;
      if(natural.equals("tree")) tree.Tree_Bool = true;
      pois.add(tree);
      
      POI bench = new POI(lat, lon);
      bench.type = amenity;
      if(amenity.equals("bench")) bench.Bench_Bool = true;
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
      if(landuse.equals("grass")) grass.Grass_Bool = true;
      polygons.add(grass);
    }
  }
 }    
