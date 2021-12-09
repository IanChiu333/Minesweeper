class Cell {
  float x;
  float y;
  float w;
  float h;
  int row;
  int col;
  public int num = 0;
  public boolean bomb;
  public boolean flag;
  public boolean reveal;
  public Cell(int x, int y, int row, int col) {
    this.x = x;
    this.y = y;
    w = 40;
    h = 40;
    this.row = row;
    this.col = col;
    bomb = false;
    flag = false;
    reveal = false;
  }
  public void show() {
    if (bomb == true && reveal == true) {
      fill(255, 0, 0);
    } else if (reveal == true) {
      fill(0, 255, 0);
    } else {
      fill(255, 255, 255);
    }
    rect(x, y, w, h);
    if (flag == true) {
      image(flagImage, x, y, w, h);
    }
    fill(0, 0, 0);
    if (bomb == false && reveal == true) {
      text(num, x+w/2, y+h/2);
    }
  }

  public boolean onLeftClick() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && cL == true) {
      return(true);
    } else {
      return(false);
    }
  }

  public boolean onRightClick() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && cR == true) {
      return(true);
    } else {
      return(false);
    }
  }

  public void checkBomb() {
    if (onLeftClick() == true && bomb == true) {
      gameOver = true;
    }
  }

  public void plantFlag() {
    if (onRightClick() == true && flag == false) {
      flag = true;
    } else if (onRightClick() == true && flag == true) {
      flag = false;
    }
  }

  public void checkZero() {
    if (num == 0) {
      for (int r = -1; r < 2; r++) {
        for (int c = -1; c < 2; c++) {
          if (col == 0 && c == -1) {
            continue;
          }
          if (col == 19 && c == 1) {
            continue;
          }
          if (row == 0 && r == -1) {
            continue;
          }
          if (row == 19 && r == 1) {
            continue;
          }
          if (grid[row+r][col+c].num == 0 && grid[row+r][col+c].reveal == false) {
            grid[row+r][col+c].reveal = true;
            grid[row+r][col+c].checkZero();
          } else {
            grid[row+r][col+c].reveal = true;
          }
        }
      }
    }
  }

  public void countBombs () {
    int count = 0;
    if (row != 0 && col != 0 && grid[row-1][col-1].bomb == true ) {
      count++;
    }
    if ( row != 0 && grid[row-1][col].bomb == true) {
      count++;
    }
    if (row!=0 && col != 19 && grid[row-1][col+1].bomb == true ) {
      count++;
    }
    if (col != 0 && grid[row][col-1].bomb == true ) {
      count++;
    }
    if (grid[row][col].bomb == true) {
      count++;
    }
    if (col != 19 && grid[row][col+1].bomb == true) {
      count++;
    }
    if (row != 19 && col != 0 && grid[row+1][col-1].bomb == true) {
      count++;
    }
    if (row != 19 && grid[row+1][col].bomb == true) {
      count++;
    }
    if (row != 19 && col != 19 && grid[row+1][col+1].bomb == true ) {
      count++;
    }
    num = count;
  }

  void update() {
    show();
    checkBomb();
    plantFlag();
    if (onLeftClick() == true) {
      reveal = true;
      checkZero();
    }
  }
}

//To Do List:
//Timer
