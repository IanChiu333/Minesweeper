PImage flagImage;
Cell[][] grid = new Cell[20][20];
boolean cL = false;
boolean cR = false;
boolean gameOver = false;
boolean firstClick = false;

void setup() {
  flagImage = loadImage("flag.png");
  size(800, 800);
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
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        grid[row][col].update();
      }
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
    int col = floor(mouseX / 40);
    int row = floor(mouseY / 40);
    println(col);
    println(row);
    placeBombs(row, col);
    firstClick = true;
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
        println(row);
        println(col);
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
