enum State{ // Enum to control the state of the program
  NONE, // Tells that program that nothing is happening
  CREATE, // Tells the program that it is currently creating a new window
  MOVE, // Tells the program that it is currently moving a window
  SIZE // Tells the program that it is currently resizing a window
}
