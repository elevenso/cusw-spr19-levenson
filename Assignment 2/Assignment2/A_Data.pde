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

    String dataPublicTransport = properties.getJSONObject("tags").getString("public_transport");
    String publictransport = properties.getJSONObject("tags").getString("public_transport");
    if (dataPublicTransport != null) publictransport = dataPublicTransport;
    else publictransport = "";
    
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
      
      POI cafe = new POI(lat, lon);
      cafe.type = amenity;
      if(amenity.equals("cafe")) cafe.Cafe_Bool = true;
      pois.add(cafe);
      
      POI restaurant = new POI(lat, lon);
      restaurant.type = amenity;
      if(amenity.equals("restaurant")) restaurant.Restaurant_Bool = true;
      pois.add(restaurant);
      
      
      POI _publictransport = new POI(lat, lon);
      _publictransport.type = publictransport;
      if(publictransport.equals("platform")) _publictransport.Transport_Bool = true;
      pois.add(_publictransport);
      }
    
    //Polygons if polygon
    if(type.equals("Polygon")){
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
      Polygon stop = new Polygon(coords);
      //if(stop.equals("stop_area")){ stop.Bus_Stop = true;
      polygons.add(stop);
      //}
    }
    
    //Way if a LineString
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
      Way way = new Way(coords);
      ways.add(way);
    }
 
    
  }
 }
