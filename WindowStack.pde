import java.util.*; // Import LinkedList

class WindowStack{ // Class to manage the windows
  LinkedList<Window> l; // LinkedList to store the windows
  
  WindowStack(){ // Constructor 
    l = new LinkedList<Window>(); // Initializes the linkedlist
  }
  
  void display(){ // Displays the windows in the linkedlist
    for(Window w : l){
      w.display();
    }
  }
  
  // Given the reference to a window, put it at the back of the list and thus in front of the other windows
  // This is because the drawing of the windows cover each other up, making the head of the linked list the farthest in the back
  void bringToFront(Window ref){
    l.remove(ref); // Remove the window from the list
    l.add(ref); // add it back to the end
  }
  
  // Adds a window to the list given two points
  // Same as the add() function but with a different name
  void addWindow(int x1, int y1, int x2, int y2){
    l.add(new Window(x1, y1, x2, y2)); // Add new window to the list
  }
  
  // Remove a window from the list given a reference to the window
  // Same as the remove() function but with a different name
  void removeWindow(Window w){
    l.remove(w); // Remove referenced window
  }
  
  Window inBound(int x, int y){ // Check if the given mouse locations click on a window
    Window temp = null; // Temp variable to store the top most window being clicked
    for(Window w : l){
      if(w.inBound(x, y)){
        temp = w; // If the click is in the bounds of a window set it as temp
      }
    }    
    return temp; // The last window set to temp will be the front most window to be clicked
  }
}
