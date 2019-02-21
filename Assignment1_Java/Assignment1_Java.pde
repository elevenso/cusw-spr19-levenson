int value = 255;
int position_x = 0;
int position_y = 0;
int counter = 0;

void setup() {
  size(640,380);
  smooth();
  background(0);
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
  
}
void keyPressed() {
  if (value==255) {
    value = 50;
  } else {
    value = 255;
  }
}

void numberCircles() {
  if (position_x != mouseX) {
    if (position_y != mouseY) {
    counter += 1;
    }
  }
  position_x = mouseX;
  position_y = mouseY;
}

void statistics() {
  text("counter", 10, 30);
  fill(0);
}
  
