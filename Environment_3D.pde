import java.awt.Robot;
color black = #000000;
color white = #FFFFFF;    //empty space
color dullblue = #7092BE; //mossy bricks
PImage cube;
PImage cube1;
Robot rbt;
int gridSize;
PImage map;
boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;
void setup() {
  size( displayWidth, displayHeight, P3D);
  map = loadImage("MicrosoftTeams-image (4).png");
  cube = loadImage("MicrosoftTeams-image (5).png");
  cube1 = loadImage("MicrosoftTeams-image (6).png");
  gridSize = 100;
  textureMode(NORMAL);
  wkey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY =9*height/10;
  eyeZ = height/2;
  focusX = width/2;
  focusY = height/2;
  focusZ = height/2 - 100;
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
  leftRightHeadAngle = radians(270);
  noCursor();
  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  drawFloor(-2000, 2000, height-gridSize * 3, gridSize);
  drawFloor(-2000, 2000, height, gridSize);
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);

  popMatrix();
}


void drawFloor() {

  stroke(255);
  for (int x = -2000; x <= 2000; x = x + 100) {
    line(x, height, -2000, x, height, 2000);
    line (-2000, height, x, 2000, height, x);
  }
}

void drawMap() {
  for (int x = 0; x < map.height; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c != white) {
        texturedCube(x * gridSize-2000, height-gridSize, y * gridSize-2000, cube, gridSize);
        texturedCube(x * gridSize-2000, height-gridSize*2, y * gridSize-2000, cube, gridSize);
        texturedCube(x * gridSize-2000, height-gridSize*3, y * gridSize-2000, cube, gridSize);
      }
      if (c == black) {
        texturedCube(x * gridSize-2000, height-gridSize, y * gridSize-2000, cube1, gridSize);
        texturedCube(x * gridSize-2000, height-gridSize*2, y * gridSize-2000, cube1, gridSize);
        texturedCube(x * gridSize-2000, height-gridSize*3, y * gridSize-2000, cube1, gridSize);
      }
    }
  }
}
void controlCamera() {

  if (wkey) {
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
  }
  if (skey) {
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
  }
  if (akey) {

    eyeX = eyeX - cos(leftRightHeadAngle + PI/2)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle + PI/2)*10;
  }
  if (dkey) {
    eyeX = eyeX - cos(leftRightHeadAngle - PI/2)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle - PI/2)*10;
  }

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX) * 0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY -pmouseY)*0.01;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle > -PI/2.5) upDownHeadAngle = -PI/2.5;


  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;

  if (mouseX > width-2) rbt.mouseMove(2, mouseY);
  else if (mouseX < 2) rbt. mouseMove(width -2, mouseY);
}
void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z < end) {
    texturedCube(x, level, z, cube1, gap);
    x = x + gap;
    if (x >= end) {
      x = start;
      z = z + gap;
    }
  }
  
}


void keyPressed() {
  if (key == 'W' || key == 'w') wkey = true;
  if (key == 'A' || key == 'a') akey = true;
  if (key == 'D' || key == 'd') dkey = true;
  if (key == 'S' || key == 's') skey = true;
}

void keyReleased() {
  if (key == 'W' || key == 'w' ) wkey = false;
  if (key == 'A' || key == 'a' ) akey = false;
  if (key == 'D' || key == 'd') dkey = false;
  if (key == 'S' || key == 's') skey = false;
}
