//add info about key command for clear

color grass_color = color(153, 230, 153);
color grass_border = color(111, 220, 111);

//add legend in grey box to the right side, instructions, description
void drawLegend(){
  noStroke();
  fill(245, 200);
  rect(width-190, 20, 180, height-40, 10);
  fill(45);
  textFont(helvetica, 14);
  text("Trees  -  't'\nBenches  -  'b'\nMap - 'm'\nClear - 'c'\n\nRegenerate students' path with a click or press 'r'!", width-180, 250, 160, 200);
  textFont(bold,18);
  fill(45);
  text("Civic Center Park", width-180, 50);
  textFont(helvetica, 16);
  text("Berkeley, CA", width-180, 75);
  textSize(14);
  text("Help this park be more welcoming! Add benches and trees to reduce the open space, and encourage high school kids to use the whole space.", width-180, 95, 160, 200); //last two parameters are width, height of text box
  text("Students: " + people.size(), width-180, 410);
  text("Emily Levenson", width-180, height-60);
  text("11.S195", width-180, height-40);
}
