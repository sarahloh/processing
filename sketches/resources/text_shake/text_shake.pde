//http://www.processing.org/tutorials/text/

PFont f;
String message = "click mouse to shake it up";
// An array of Letter objects
Letter[] letters;
int[] colours = {#2EB8E6, #33CCFF, #29A3CC, #248FB2, #47D1FF};


void setup() {
  size(260, 200);
  // Load the font
  f = createFont("Arial",20,true);
  textFont(f);
  
  // Create the array the same size as the String
  letters = new Letter[message.length()];
  // Initialize Letters at the correct x location
  int x = 16;
  for (int i = 0; i < message.length(); i++) {
    letters[i] = new Letter(x,100,message.charAt(i)); 
    x += textWidth(message.charAt(i));
  }
}

void draw() { 
  background(0);
  for (int i = 0; i < letters.length; i++) {
    // Display all letters
    letters[i].display();
    
    // If the mouse is pressed the letters shake
    // If not, they return to their original location
    if (mousePressed) {
      letters[i].shake();
    } else {
      letters[i].home();
    }
  }
}

// A class to describe a single Letter
class Letter {
  char letter;
  // The object knows its original "home" location
  float homex,homey;
  // As well as its current location
  float x,y;

  Letter (float x_, float y_, char letter_) {
    homex = x = x_;
    homey = y = y_;
    letter = letter_; 
  }

  // Display the letter
  void display() {
    int colour = colours[(int)random(5)];
    fill(colour);
    textAlign(LEFT);
    text(letter,x,y);
  }

  // Move the letter randomly
  void shake() {
    x += random(-2,2);
    y += random(-2,2);
  }

  // Return the letter home
  void home() {
    x = homex;
    y = homey; 
  }
}
