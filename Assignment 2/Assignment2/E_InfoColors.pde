color poi_fill = color(255,99,71);
color bus_stop_color = color(255,255,0);
color cafe_fill = color(32, 178,170);

void drawInfo(){
  //Legend - make sure to include in homework!
  fill(0);
  rect(20, 20, 125, 90);
  textSize(16);
  fill(bus_stop_color);
  text("Bus Stop", 25, 60);
  fill(cafe_fill);
  text("Cafes", 25, 80);
}
