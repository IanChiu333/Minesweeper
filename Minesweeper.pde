PImage flagImage;
Cell[][] grid = new Cell[20][20];
boolean cL = false;
boolean cR = false;
boolean gameOver = false;
boolean firstClick = false;
int seconds = 0;
int timeStart = 0;

void setup() {
  flagImage = loadImage("flag.png");
  size(840, 800);
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      Cell c = new Cell(row*40, col*40, row, col);
      grid[row][col] = c;
    }
  }
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      grid[row][col].update();
    }
  }
}

void draw() {
  if (firstClick == true) {
    background(0);
    seconds = (millis() - timeStart)/1000;
    fill(255);
    text(seconds, 800, 40);
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        grid[row][col].update();
      }
    }
    if (win() == true) {
      background(0,255,0);
    }
  }
  if (gameOver == true) {
    background(255, 0, 0);
  }
  cL = false;
  cR = false;
}

void mouseClicked() {
  if (firstClick == false) {
    int row = floor(mouseX / 40);
    int col = floor(mouseY / 40);
    placeBombs(row, col);
    firstClick = true;
    timeStart = millis();
  }
  if (mouseButton == LEFT) {
    cL = true;
  } else if (mouseButton == RIGHT) {
    cR = true;
  }
}

void placeBombs(int r, int c) {
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      if (row >= r-1 && row <= r+1 && col >= c-1 && col <= c+1) {
        grid[row][col].bomb = false;
      } else {
        int x = (int)(random(0, 5));
        if (x == 0) {
          grid[row][col].bomb = true;
        }
      }
    }
  }
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[row].length; col++) {
      grid[row][col].countBombs();
    }
  }
}

boolean win() {
  int counter = 0;
  for (int row=0; row < grid.length; row++) {
    for (int col=0; col < grid[row].length; col++) {
      if (grid[row][col].bomb == false && grid[row][col].reveal == false) {
        counter++;
      }
    }
  }
  if (counter == 0) {
    return(true);
  } else {
    return(false);
  }
}
