int value = 255;
int position_x = 0;
int position_y = 0;
int counter = 0;
String stat_1 = "To know the number of circles, press 'c'";

void setup() {
  size(640,380);
  background(0);
  frameRate(60);
}

void draw() {
  
  if (mousePressed) {
    fill(255, 200, 50);
    
  } else {
    fill(255, 100, 50);
  }
  
  quad(mouseX+50, mouseY+50, 199, 14, 392, 66, 351, 107);
  
  arc(mouseX+40, mouseY+40, 40, 40, QUARTER_PI, PI+QUARTER_PI);
  
  fill(value, 50, 10);
  circle(mouseX+10, mouseY+10, 50);
  
  
  keyTyped();
  fill(255);
  textSize(14);
  textAlign(RIGHT);
  text(stat_1, 635, 355);
  int s = second();  // Values from 0 - 59
  text("Seconds passed:" + s,600,300);
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
  
