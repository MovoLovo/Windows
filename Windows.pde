/**
* @author Spencillian
* @date 4 March 2021
*/

// Global Variables
WindowStack stack; // Controls and manages the order of windows (name is a misnomer, doesn't actually use a stack)
State s; // Stores the state of the program (congrats, your assignments have achieve state management difficulty levels)
int saveX, saveY; // Temporary spot to save mouse location
Window focusRef; // The reference to the window in focus
final int MIN_SIZE = 200; // Minimum size of the window (To guard against edge cases where the window would be too small to click on)

// Program config stuff
void setup(){
  fullScreen(); // This is just a config setting to make the program easier to use (i have no idea what resolution screen you have)
//  size(1500, 1500); if you want a windowed program uncomment this line and comment out the line above
  rectMode(CORNERS); // Configure rectangle draw move
  
  stack = new WindowStack(); // Initialize new WindowStack
  
  s = State.NONE; // Set the initial state of the program (explained in more detail in the State enum)
  
  // Configure text settings
  textSize(50);
  textAlign(CENTER, BOTTOM);
}

// Active animation code
void draw(){
  background(200); // Refresh the background
  fill(0);
  text("Click and Drag to create a window", width/2, height/2); // Comment this out if it gets too obnoxious
  stack.display(); // Display every window in the "stack"
  
  // Active redrawing of the indicator rectangle 
  // The indicator rectangle is red or green rectangle that shows up when you try and create a new rectangle
  if(s == State.CREATE){ // If the program state is in create mode
    if(abs(saveX - mouseX) < MIN_SIZE || abs(saveY - mouseY) < MIN_SIZE){ // Check if the size of the window is large enough to be created
      noStroke();
      fill(200, 150, 150); // Make the indicator rectangle red if its too small
    }else{
      noStroke();
      fill(150, 200, 150); // Green if the rectangle is big enough
    }
    rect(saveX, saveY, mouseX, mouseY); // Draw the indicator rectangle
  }
}

// Manage state and perform other actions for when the mouse is pressed down
void mousePressed(){
  // Save the position of the mouse for later use
  saveX = mouseX;
  saveY = mouseY;
  
  focusRef = stack.inBound(mouseX, mouseY); // Get the focused window if there was one that was clicked
  
  if(focusRef != null && focusRef.shouldExit(saveX, saveY)){ // If the x on the window is clicked
    stack.removeWindow(focusRef); // Remove the focused window from the linkedlist
    return; // Exit function
  }
  
  if(focusRef != null && focusRef.shouldResize(saveX, saveY)){ // If the resize button is clicked
    s = State.SIZE; // Set the state of program to SIZE so that the program knows that it is resizing a window
    stack.bringToFront(focusRef); // Bring the focused window to the front
    return; // Exit function
  }
    
  if(focusRef != null){ // If the window is just clicked on
    s = State.MOVE; // Set the state to MOVE
    stack.bringToFront(focusRef); // Bring the clicked window to the front
    focusRef.setColor(color(random(255), random(255), random(255))); // Color the window randomly when it is in focus
    return; // Exit function
  }
  
  s = State.CREATE; // If nothing is clicked on, the user is trying to create a new rectangle
}

// Manage the state of the program when mouse presses are released as well as finalizing some other operations
void mouseReleased(){
  if(s == State.CREATE){ // If the program is creating a new window
    if(!(abs(saveX - mouseX) < MIN_SIZE || abs(saveY - mouseY) < MIN_SIZE)){ // and the window is the right size
      stack.addWindow(saveX, saveY, mouseX, mouseY); // add the window to the linked list
    }
  }
  
  s = State.NONE; // Reset the state to NONE
}

// Manages animations for when the mouse is dragged. Semi active animation
void mouseDragged(){  
  if(s == State.MOVE){ // If the program is moving a rectangle
    focusRef.setLocation(mouseX, mouseY); // Set it's location to that of the mouse
  }
  
  if(s == State.SIZE){ // If the program is resizing a rectangle
    focusRef.setSize(mouseX, mouseY); // Move the corner of the window to the mouse
  }
}
