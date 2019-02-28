color poi_fill = color(15,255,100);
color restaurant_fill = color(255,255,0);
color polygon_color = color(15,15,100, 90);
color cafe_fill = color(255,100,0);
color road_color = color(20,100,255); //make this magenta
color transport_fill = color(15,255,100);

void drawInfo(){
  //Legend - make sure to include in homework!
  fill(0,185);
  rect(20, 20, 220, 130);
  textSize(16);
  fill(transport_fill);
  text("Public Transportation", 25, 100);
  //fill(poi_fill);
  //text("POIs", 25, 40);
  fill(restaurant_fill);
  text("Restaurants", 25, 40);
  fill(cafe_fill);
  text("Cafes", 25, 60);
  fill(road_color);
  text("Roads", 25, 80);
  fill(255);
  text("try pressing 'p', 'b', and 'r'", 25, 120);
  text("press 'c' to clear", 25, 140);
}
