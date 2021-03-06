Table SchoolBoundary, CensusData, CensusBlocks;

void loadData(){
  background = loadImage("data/Bay_Area.png");
  background.resize(width, height);
  SchoolBoundary = loadTable("data/Attributes.csv", "header");
  CensusBlocks = loadTable("data/Nodes.csv", "header");
  CensusData = loadTable("data/Geometry.csv", "header");
  println("Data Loaded");
}

void parseData(){
  //First parse district polygon
    ArrayList<PVector> coords = new ArrayList<PVector>();
    for(int i = 0; i<SchoolBoundary.getRowCount(); i++){
         float lat = float(SchoolBoundary.getString(i, 2));
         float lon = float(SchoolBoundary.getString(i, 1));
         coords.add(new PVector(lat, lon));
    }
   district = new Polygon(coords);
   district.outline = true;
   district.makeShape();  
   
   households = new Polygon(coords);
   households.outline = true;
   households.makeShape();  

//Now we can parse the population polygons
  int previd = 0;
  coords = new ArrayList<PVector>();
  for(int i = 0; i<CensusBlocks.getRowCount(); i++){
    int shapeid = int(CensusBlocks.getString(i, 0));
       if(shapeid != previd){
           if(coords.size() > 0){
               Polygon poly = new Polygon(coords);
               poly.id = shapeid;
               CensusPolygons.add(poly);
           }
           //clear coords
           coords = new ArrayList<PVector>();
           //reset variable
           previd = shapeid;
       }
       if(shapeid == previd){
         float lat = float(CensusBlocks.getString(i, 2));
         float lon = float(CensusBlocks.getString(i, 1));
         //println(lat, lon);
         coords.add(new PVector(lat, lon));
       }
  }
  
  //Add attributes to polygon
  for(int i = 0; i<CensusPolygons.size(); i++){
    CensusPolygons.get(i).score = CensusData.getFloat(i, "DP0020001"); //median age
    CensusPolygons.get(i).colorByScore();
    //CensusPolygons.get(i).makeShape();
    CensusPolygons.get(i).household_score = (CensusData.getFloat(i, "DP0130003")/(CensusData.getFloat(i, "DP0130001")-CensusData.getFloat(i, "DP0130003"))); //households w/ children/households withoutl    CensusPolygons.get(i).colorHouseholdsByScore();
    CensusPolygons.get(i).colorHouseholdsByScore();
    CensusPolygons.get(i).makeShape();
    /**CensusPolygons.get(i).label = CensusData.getString(i, "NAME10"); //district label
    CensusPolygons.get(i).labelLocation();*/
  }
  
  println("Data Parsed");
}
