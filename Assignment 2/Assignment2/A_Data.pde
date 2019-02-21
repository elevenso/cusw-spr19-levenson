JSONObject example;
JSONArray features;
JSONObject wholeArea;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("Berkeley_background.png");
  background.resize(width, height);
  
  //Whole area
  wholeArea = loadJSONObject("Berkley_map.geojson");
  features = wholeArea.getJSONArray("features");
  
  //Small example - start with this!
  //example = loadJSONObject("Berkley_map.geojson");
  //features = example.getJSONArray("features");
  
  println("There are: ", features.size(), " features");
}

void parseData(){
  for (int i=0; i<features.size(); i++){
    //Identify 3: properties, geometry, and type
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
    
    //identify more information!
    String dataAmenity = properties.getJSONObject("tags").getString("amenity");
    String amenity = "";
    //there will be gaps in data, so make sure to check for these
    if (dataAmenity != null) amenity = dataAmenity;
    
    //Make POIs!
    if(type.equals("Point")){
      //create a new POI
      //Coordinates is array with floats inside, lon first, then lat
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      
      POI poi = new POI(lat, lon);
      poi.type = amenity;
      //no curly brackets needed if one line if statement
      if(amenity.equals("arts_centre")){
        poi.Arts_Centre = true;
      }
      pois.add(poi);
    } 
  }
}
