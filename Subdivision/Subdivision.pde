// SUBDIVISION
// keyboard controls:
//  n = new frame
//  1/2/3/4 = toggle drawing mode
//  left = decrease number of subdivisions (min 1, default 13)
//  right = increase number of subdivisions (max 20, default 13)
//  s = save a BMP screenshot

int mode;
int numLevels;

void setup() {
  size(1024, 1024);
  noLoop();
  numLevels = 13;
  mode = 1;
}

void draw() {
  background(255);
  drawBox(numLevels, 0, 0, width, height);
}

void drawBox(int n, float x, float y, float w, float h) {
  if (n==0) {
    if      (mode==1) {
      noFill();
      stroke(0);
      rect(x, y, w, h);
    }
    else if (mode==2) {
      noFill();
      stroke(0);
      ellipse(x + w/2, y + h/2, w*0.95, h*0.95);
    }
    else if (mode==3) {
      line(x, y, x + w, y + h);
      line(x+w, y, x, y + h);
    }
    else if (mode==4) {
      noStroke();
      fill(0, random(40, 255));
      rect(x, y, w, h);
    }
  } else {
    float t = random(1);
    boolean horiz = random(1) > 0.5 ? true : false;
    if (random(1) > 0.5) {
      drawBox(n-1, x, y, w, h*t);
      drawBox(n-1, x, y+h*t, w, h*(1-t));  
    } else {
      drawBox(n-1, x, y, w*t, h);
      drawBox(n-1, x+w*t, y, w*(1-t), h);  
    }      
  }
}

void keyPressed() {
  if      (key=='n')       { redraw(); }
  else if (key=='1')       { mode=1;  redraw(); }
  else if (key=='2')       { mode=2;  redraw(); }
  else if (key=='3')       { mode=3;  redraw(); }
  else if (key=='4')       { mode=4;  redraw(); }
  else if (key=='s')       { saveFrame("frame####.png"); } 
  else if (keyCode==LEFT)  { numLevels = constrain(numLevels-1, 1, 20);  redraw(); }
  else if (keyCode==RIGHT) { numLevels = constrain(numLevels+1, 1, 20);  redraw(); }
}
