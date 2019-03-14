color tree_color = color(255, 81, 0);
color tree_border = color(255, 0, 15);
color bench_color = color (153, 76, 0);
color bench_border = color(102, 51, 0);
color grass_color = color(153, 230, 153);
color grass_border = color(111, 220, 111);
color footway_color = color(255, 0, 50, 100);

//add legend in grey box to the right side, instructions, description
void drawLegend(){
  fill(245);
  rect(width-190, 20, 180, 210);
  textSize(18);
  fill(45);
  text("Civic Center Park", width-180, 50);
  textSize(16);
  text("Berkeley, CA", width-180, 75);
  textSize(14);
  fill(tree_border);
  text("Trees", width-180, 110);
  fill(bench_border);
  text("Benches", width-180, 140);
  fill(grass_border);
  text("Grass", width-180, 170);
}
