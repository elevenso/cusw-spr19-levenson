JSONObject example;
JSONArray features;
JSONObject wholeArea;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("Berkeley_background.png");
  background.resize(width, height);
  
  //Whole area
  wholeArea = loadJSONObject("Berkeley.JSON");
  features = wholeArea.getJSONArray("features");
  
  println("There are: ", features.size(), " features");
}

void parseData(){
  //general object
  //JSONObject feature = features.getJSONObject(0);
  
  for (int i=0; i< features.size(); i++){
    //Identify 3: properties, geometry, and type
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
    
    //identify more information!
    String dataHighway = properties.getJSONObject("tags").getString("highway");
    String highway = properties.getJSONObject("tags").getString("highway");
    //there will be gaps in data, so make sure to check for these
    if (dataHighway != null) highway = dataHighway;
    else highway = "";
    
    String dataAmenity = properties.getJSONObject("tags").getString("amenity");
    String amenity = properties.getJSONObject("tags").getString("amenity");
    //there will be gaps in data, so make sure to check for these
    if (dataAmenity != null) amenity = dataAmenity;
    else amenity = "";
    
    //Make POIs!
    if(type.equals("Point")){
      //create a new POI
      //Coordinates is array with floats inside, lon first, then lat
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      
      POI poi = new POI(lat, lon);
      poi.type = highway;
      if(highway.equals("bus_stop")) poi.Bus_Stop = true;
      pois.add(poi);
      
      POI cafe = new POI(lat, lon);
      poi.type = amenity;
      if(amenity.equals("cafe")) poi.Cafe_Bool = true;
      pois.add(cafe);
      }
    
    //Polygons if polygon
    /**if(type.equals("Polygon")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      //get the coordinates and iterate through them
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for(int j = 0; j<coordinates.size(); j++){
        float _lat = coordinates.getJSONArray(j).getFloat(1);
        float _lon = coordinates.getJSONArray(j).getFloat(0);
        //Make a PVector and add it
        PVector coordinate = new PVector(_lat, _lon);
        coords.add(coordinate);
      }
      //Create the Polygon with the coordinate PVectors
      Polygon poly = new Polygon(coords);
      polygons.add(poly);
    }
    */
    
  }
 }
