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
  rect(width-190, 20, 180, 400);
  fill(45);
  textFont(helvetica, 14);
  fill(tree_border);
  text("Trees", width-180, 200);
  fill(bench_border);
  text("Benches", width-180, 225);
  fill(grass_border);
  text("Grass", width-180, 250);
}
// could write a program to lay out lines instead of manually placing each line
void drawInformation(){
  textFont(bold,18);
  fill(45);
  text("Civic Center Park", width-180, 50);
  textFont(helvetica, 16);
  text("Berkeley, CA", width-180, 75);
  textSize(12);
  text("Help this park be more welco-", width-180, 110);
  text("ming! Add benches and garden", width-180, 125);
  text("plots to reduce the open space,", width-180, 140);
  text("and encourage high school", width-180, 155);
  text("kids to use the whole space.", width-180, 170);
  text("Emily Levenson", width-180, 380);
  text("11.S195", width-180, 400);
}
