//add legend in grey box to the right side, instructions, description
void drawLegend(){
  int margin = width-170;
  int margin2 = margin+40;
  update(mouseX, mouseY);
  noStroke();
  fill(245, 200);
  rect(width-190, 20, 180, height-40, 10);
  //key
    fill(45, 200);
    rect(width-180, height-640, 160, 250, 10);
    fill(255);
    textFont(bold, 27);
    text("Key:", margin, height-600);
    image(stars, margin, height-580);
    textFont(helvetica, 14);
    text("Points of Interest", margin2, height-560);

    image(trees, margin, height-540);
    text("'t' - Trees", margin2, height-520);
    
    image(benches, margin, height-485);
    text("'b' - Benches", margin2, height-470);
    text("'m' - Map\n'c' - Clear\n'f' - Frame Rate", margin, height-450, 160, 200);
    if (playOver == true){
      //population slider - only visible when population simulation running
      fill(#27408b, 100); //light blue
      rect(width-180, 368, 160, 25, 10);
      fill(#436eee); //dark blue, drop shadow color
      rect(width-180, 368, 1.6*people.size(), 25, 10);
      textSize(16);
      fill(255);
      text("Visitors: " + people.size(), width-173, 385);
    }
    
  //information buttons
    fill(#27408b, 100); //drop shadow blue
    circle(infoX+3, infoY+3, 35);
    fill(#436eee); //light blue
    circle(infoX, infoY, 35);
    fill(#8b0000, 100); //drop shadow red
    circle(warningX+3, warningY+3, 35);
    fill(#cd0000); //red
    circle(warningX, warningY, 35);
    fill(#8b8b00, 97); //drop shadow green
    circle(playX+3, playY+3, 35);
    fill(#7ba428); //green
    circle(playX, playY, 35);
    fill(255);
    textFont(bold, 27);
    text("i", width-157, height-50);
    text("!", width-107, height-50);
    triangle(width-60, height-70, width-60, height-50, width-40, height-60);
    
  textSize(18);
  fill(45);
  text("Civic Center Park", width-180, 50);
  textFont(helvetica, 16);
  text("Berkeley, CA", width-180, 80);
  button();
  
  if (area_bool == false){
    text("Error: Too little open space", width-180, height-100);
  }
}
