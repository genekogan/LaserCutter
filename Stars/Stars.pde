// STARS
// keyboard controls:
//  n = new frame
//  left/right = toggle number of horizontal (1-30, default 3)
//  up/down = toggle number of vertical (1-20, default 1)
//  s = save a BMP screenshot

// global attributes
int nx, ny;

// star attributes
PVector[] points;
int n;
float rad;
int[] skips;

// color attributes
float alphaStroke, alphaFill;
float strokeWt;

void setup() {
  size(1440, 960);
  smooth();
  noLoop();
  nx = 3;
  ny = 1;
}

void refreshStar()
{
  n = (int) random(8, 24);        // sets number of points on the star

  // randomizes number of skips to make in drawing each segment 
  do {
    skips = new int[] { 
      (int) random(1, n), (int) random(1, n), (int) random(1, n)
    };
  } 
  while ( n % skips[2] == 0);

  // star's radius
  rad = min(width/(2*nx), height/(2*ny));
  rad = random(rad*0.9, rad);
  
  // initialize the stars points
  points = new PVector[n];
  for (int i = 0; i < n; i++) {
    float ang = lerp(0, TWO_PI, (float) i/n);
    points[i] = new PVector( rad * cos(ang), rad * sin(ang) );
  }

  // initialize stroke and fill colors, and stroke weight
  alphaStroke = random(50, 120);
  alphaFill = random(80);  
  strokeWt = random(0.7, 2);
}

void drawStar() {
  strokeWeight(strokeWt);
  stroke(0, alphaStroke);
  fill(0, alphaFill);

  int idx1 = 0;
  do {
    int idx2 = (idx1 + skips[0]) % n;
    int idx3 = (idx1 + skips[1]) % n;
    int idx4 = (idx1 + skips[2]) % n;
    
    beginShape();
      curveVertex(points[idx1].x, points[idx1].y);
      curveVertex(points[idx2].x, points[idx2].y);
      curveVertex(points[idx3].x, points[idx3].y);
      curveVertex(points[idx4].x, points[idx4].y);
    endShape(CLOSE);
  
    bezier( points[idx1].x, points[idx1].y, 
            points[idx2].x, points[idx2].y, 
            points[idx3].x, points[idx3].y, 
            points[idx4].x, points[idx4].y );


    idx1 = idx3;
  } 
  while (idx1 != 0); 
}

void draw()
{
  background(255);   
  for (int i=0; i<nx; i++) {
    for (int j=0; j<ny; j++) {
      pushMatrix();
      translate((1+2*i)*width/(2*nx), (1+2*j)*height/(2*ny));
      refreshStar();
      drawStar();
      popMatrix();
    }
  }
}  

void keyPressed() {
  if      (key=='n')       redraw();
  else if (key=='s')       saveFrame("frame####.bmp");
  else if (keyCode==LEFT)  { nx = constrain(nx-1, 1, 30);  redraw(); }
  else if (keyCode==RIGHT) { nx = constrain(nx+1, 1, 30);  redraw(); }
  else if (keyCode==DOWN)  { ny = constrain(ny-1, 1, 20);  redraw(); }
  else if (keyCode==UP)    { ny = constrain(ny+1, 1, 20);  redraw(); }
}
