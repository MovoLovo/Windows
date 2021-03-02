class Window{ // Class for individual windows
  int x1, y1, x2, y2, wide, tall; // Variables information about the window
  
  final int BUTTON_HEIGHT = 50, BUTTON_WIDTH = 75; // Magic numbers for the size of the buttons (adjust them if they are too big or small)
  
  Window(int x1, int y1, int x2, int y2){ // Constructor
    // The purpose of the next two if statements is to guarentee the orientation of the window
    if(x1 > x2){ // If statement that makes sure the the x2 is always greater than x1
      this.x1 = x2;
      this.x2 = x1;
    }else{
      this.x1 = x1;
      this.x2 = x2;
    }
    
    if(y1 > y2){ // If statement that makes sure that y2 is always greater than y1
      this.y1 = y2;
      this.y2 = y1;
    }else{
      this.y1 = y1;
      this.y2 = y2;
    }
    
    // Store the height and width of the rectangle for later use
    this.wide = abs(x2 - x1);
    this.tall = abs(y2 - y1);
  }
  
  void display(){ // Draw the window
    
    // Draw the base rectangle
    stroke(0);
    fill(255);
    rect(x1, y1, x2, y2);
    
    // Draw the exit button
    noStroke();
    fill(225, 50, 50);
    rect(x2 - BUTTON_WIDTH, y1 + BUTTON_HEIGHT, x2, y1);
    fill(0);
    text('x', x2 - BUTTON_WIDTH/2, y1 + BUTTON_HEIGHT);
    
    // Draw the resize button
    noStroke();
    fill(225);
    rect(x2 - BUTTON_WIDTH, y2 - BUTTON_HEIGHT, x2, y2);
    fill(0);
    text("<>",  x2 - BUTTON_WIDTH/2, y2);
  }
  
  // Function to check if a point on the screen is within the bounds of the rectangle
  boolean inBound(int x, int y){
    return inBound(x, y, x1, y1, x2, y2);
  }
  
  // Function to check if a point on the screen is within the bounds of the exit button of this window 
  boolean shouldExit(int x, int y){
    return inBound(x, y, x2 - BUTTON_WIDTH, y1 + BUTTON_HEIGHT, x2, y1);
  }
  
  // Function to check if the a point on the screen is within the bounds of the resize button of this window
  boolean shouldResize(int x, int y){
    return inBound(x, y, x2 - BUTTON_WIDTH, y2 - BUTTON_HEIGHT, x2, y2);
  }
  
  // General bounds detection function that is agnostic of the orientation of the rectangle
  boolean inBound(int x, int y, int x1, int y1, int x2, int y2){
    return abs(x2 - x1) / 2 > abs(x - (x2 + x1) / 2) && abs(y2 - y1) / 2 > abs(y - (y2 + y1) / 2);
  }
  
  // Set the location of this window for moving
  void setLocation(int x, int y){
    // Set the parameters of the corners of the rectangle based on the give x and y location
    this.x1 = x - wide / 2;
    this.y1 = y - tall / 2;
    this.x2 = x + wide / 2;
    this.y2 = y + tall / 2;
  }
  
  // Set the size of this window for resizing
  void setSize(int x, int y){
    if(x - x1 > MIN_SIZE && y - y1 > MIN_SIZE){ // If the size of the resize is smaller then the minimum size of the window, don't resize 
      
      // Set the bottom corner of the window to given x and y location
      this.x2 = x;
      this.y2 = y;
      
      // Recalculate width and height
      this.wide = abs(x2 - x1);
      this.tall = abs(y2 - y1);
    }
  }
}
