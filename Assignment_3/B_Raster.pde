/**class Raster{
  //Simple class for a square raster
  float cellSize, w, h;
  int numX, numY;
  PVector start;
  PVector[][] centers;
  float[][] _scores;
  
  Raster(float _size, float _w, float _h){
    w = _w;
    h = _h;
    numX = int(w/_size);
    numY = int(h/_size);
    cellSize = _size;
    centers = new PVector[numX][numY];
    _scores = new float[numX][numY];
    start = new PVector(0, 0);
    generateCenters();
    bucketRasterPolys(CensusPolygons);
  }
  
  void generateCenters(){
    for(int i = 0; i<numX; i++){
      for(int j = 0; j<numY; j++){
        centers[i][j] = new PVector(i*(start.x + cellSize) + cellSize/2, j*(start.y + cellSize) + cellSize/2);
      }
    }
  }
  
  void bucketRasterPolys(ArrayList<Polygon>polys){
    //For now, we're just going to assign each cell a score based on what polygon its center is in 
    //If it isn't in any, then we just give it a score of 0 
    //You can always assign multiple scores, etc 
    //And then combine this with a HeatMap situation, like in another tutorial
    
    for(int i = 0; i<numX; i++){
      for(int j = 0; j<numY; j++){
        _scores[i][j] = 0;
        for(int k = 0; k<polys.size();k ++){
          Polygon p = polys.get(k);
          PVector l = centers[i][j];
          if(p.pointInPolygon(map.getGeo(l))){
            //println(p.score);
            _scores[i][j] = p._score;
          }
        }
        
      }
    }
    
  }
  
class Heatmap{
  int cellX, cellY;
  float cellW, cellH;
  float[][] _scores;
  color worst, mid, best;
  PGraphics p;
 
  Heatmap(){}
  
  Heatmap(int _cellX, int _cellY, float _cellW, float _cellH){
    cellX = _cellX;
    cellY = _cellY;
    cellW = _cellW;
    cellH = _cellH;
    worst = color(200, 0, 0);
    mid = color(255, 255, 0);
    best = color(0, 200, 0);
    _scores = new float[cellX][cellY];
    p = createGraphics(int(cellX*cellW), int(cellY*cellH));
    
  }
  
  void normalizeScores(){
    float min = 1000000;
    float max = 0;
    for(int i = 0; i<cellX; i++){
      for(int j = 0; j<cellY; j++){
        float val = _scores[i][j];
        if (val < min) min = val;
        if (val > max) max = val;
      }
    }
    
    for(int i = 0; i<cellX; i++){
      for(int j = 0; j<cellY; j++){
        float val = _scores[i][j];
        float newVal = map(val, min, max, 0, 100);
        _scores[i][j] = newVal;
      }
    }
  }
    
  void draw(){
    p.beginDraw();
    p.clear();
    for(int i = 0; i<numX; i++){
      for(int j = 0; j<numY; j++){
        color col = color(0, 0, 0);
        float val = _scores[i][j];
        if(val*255/56000 < 50) col = lerpColor(worst, mid, val/100); //convert data to color
        if(val*255/56000 == 50) col = mid;
        if(val*255/56000 > 50) col = lerpColor(mid, best, val/100);
        p.fill(col);
        p.stroke(0);
      rect(i*(start.x + cellSize), j*(start.y + cellSize), cellSize, cellSize);
      ellipse(centers[i][j].x, centers[i][j].y, 1, 1);
      }
    }
    p.endDraw();
  }
}
}
*/
