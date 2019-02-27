int value = 255;
int position_x = 0;
int position_y = 0;
int counter = 0;
String stat_1 = "To know the number of circles, press 'c'";
PGraphics art, text;

void setup() {
  size(640,380);
  frameRate(60);
  //create Off Screen graphics (holding layers in "cloud")
  art = createGraphics(width, height);
  text = createGraphics(width, height);
  
  //draw black background once
  art.beginDraw();
  art.background(0);
  art.endDraw();
}

void draw() {
  //draw art on layer off screen
  art.beginDraw();
  if (mousePressed) {
    art.fill(255, 200, 50);
    
  } else {
    art.fill(255, 100, 50);
  }
  
  art.quad(mouseX+50, mouseY+50, 199, 14, 392, 66, 351, 107);
  
  art.arc(mouseX+40, mouseY+40, 40, 40, QUARTER_PI, PI+QUARTER_PI);
  
  art.fill(value, 50, 10);
  art.circle(mouseX+10, mouseY+10, 50);
  art.endDraw(); //stop drawing on layer
  
  
  keyTyped();
  text.beginDraw();
  text.clear();
  text.fill(255);
  text.textSize(14);
  text.textAlign(RIGHT);
  text.text(stat_1, 635, 355);
  int s = second();  // Values from 0 - 59
  text.text("Seconds passed:" + s,600,300);
  text.endDraw();
  
  //draw layers on visible canvas in top left corner (origin)
  image(art, 0, 0);
  image(text, 0, 0);
}
  
void keyPressed() {
  if (value==255) {
    value = 50;
  } else {
    value = 255;
  }
}

void keyTyped() {
  if (key=='c') {
    counter = counter + 1;
    stat_1 = Integer.toString(counter);
  }
}
  
