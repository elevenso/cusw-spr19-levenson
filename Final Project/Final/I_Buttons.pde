//code adapted from Processing reference

int infoX, infoY;      // Position of info button
int warningX, warningY;  // Position of warning button
int playX, playY;  // Position of play button
int circleSize = 30;     // Diameter of circle
boolean infoOver = false;
boolean warningOver = false;
boolean playOver = false; 

void update(int x, int y) {
  if ( overInfo(infoX, infoY, circleSize) ) {
    infoOver = true;
    warningOver = false;
  } else if ( overWarning(warningX, warningY, circleSize) ) {
    warningOver = true;
    infoOver = false;
  } else if ( overPlay(playX, playY, circleSize) ) {
    warningOver = false;
    infoOver = false;
      if (playOver == true & clicked){
        playOver = false;
        clicked = false;
      } 
      else if (clicked == true){
        playOver = true;
        clicked = false;
      }
  } else {
    infoOver = warningOver = false;
  }
}

//displays information when hover over button
void button(){
    if (infoOver) {
    //information popup
    information.beginDraw();
    information.noStroke();
    information.fill(45, 200);
    information.rect(width-180, height-350, 160, 250, 10);
    information.fill(200);
    information.textSize(14);
    information.text("Help this park be more welcoming! Add benches and trees to reduce the open space, and encourage high school kids to hang out here.", width-170, height-330, 140, 200); //last two parameters are width, height of text box
    information.text("Emily Levenson", width-170, height-145);
    information.text("11.S195", width-170, height-125);
    information.endDraw();
    }
    else if (warningOver){
    information.beginDraw();
    information.noStroke();
    information.fill(45, 200);
    information.rect(width-180, height-350, 160, 250, 10);
    information.fill(200);
    information.textSize(14);
    information.text("Don't cut off too much space or else there won't be room for festivals and sports.", width-170, height-330, 140, 200); //last two parameters are width, height of text box
    information.endDraw();
    }
    else{
    information.beginDraw();
    information.clear();
    information.endDraw();
    }
}

boolean overInfo(int x, int y, int diameter)  {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

boolean overWarning(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

boolean overPlay(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
