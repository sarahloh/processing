//http://www.processing.org/tutorials/text/

import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

PFont f1;
PFont f2;
PFont f3;
String[] tweets = {
  "#ProjectionMapping &amp; Audio/Video in the General Session @ the Nissan Leadership Forum #eventtech #eventprofs http://t.co/YnGfJuPAKl",
  "expensive yet impressive #projectionmapping http://t.co/nOsCjaocl6 http://t.co/KuHeGLEoqM",
  "Getting weird in the Tetons #projectionmapping #skiing #redcinema @ somewhere in wyoming http://t.co/MCzZ2hNOB8",
  "#sxsw #projectionmapping courtesy of @sensai5000 collabnart @ Bo Concept http://t.co/dFnx6wmWwp",
  "Video: More customers playing with our #interactive #projectionmapping #installation. #soho #newyork... http://t.co/wc437nacLg",
  "More customers playing with our #interactive #projectionmapping #installation. #soho #newyork… http://t.co/54o40Dm6z5",
  "#projectionmapping with bklyn1834 and collabnart #sxsw2014 http://t.co/gqZlKQHz7b",
  "Photo: Today someone else drew the same exact thing I drew on our #interactive #projectionmapping... http://t.co/jpkvMPxzjo",
  "Today someone else drew the same exact thing I drew on our #interactive #projectionmapping… http://t.co/GroRo3Smk3",
  "Video: Customers playing with our #interactive #projectionmapping http://t.co/0Mqq4blfOJ",
  "Customers playing with our #interactive #projectionmapping http://t.co/kr90Djgb50",
  "Another angle of #refikanadol scale replica of #waltdisneyconcerthall #projectionmapping soon http://t.co/SMGQWspstr",
  "Projection mapping sobre elementos móviles - #oldpost http://t.co/OuS8NP2d56 #ProjectionMapping"
};
//String message = "click mouse to shake it up";
float x; // Horizontal location
int index = 0;
String tweet;
// An array of Letter objects
Letter[] letters;
int[] colours = {#2EB8E6, #33CCFF, #29A3CC, #248FB2, #47D1FF};
PFont[] fonts = {f1, f2, f3};


void setup() {
  size(260, 200, P3D);
  canvas = createGraphics(260, 200, P3D);
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
  // Load the font
  fonts[0] = createFont("Ubuntu",20,true);
  fonts[1] = createFont("Ariel",20,true);
  fonts[2] = createFont("Franklin",20,true);
  
  textFont(fonts[0], 20);
  
  // Initialize letters offscreen
  x = width;
  
//  // Create the array the same size as the String
//  letters = new Letter[message.length()];
//
//  for (int i = 0; i < message.length(); i++) {
//    letters[i] = new Letter(x,100,message.charAt(i), random(20,30)); 
//    x += textWidth(message.charAt(i)) + 3;
//  }
}

void draw() { 
  canvas.beginDraw();
  canvas.background(0);
  
  
  for (int i = 0; i < tweets.length; i++) {
    System.out.println("i = " + i);
    tweet = tweets[i];
//  System.out.println(tweet);
    // Put tweet into letters array
    letters = new Letter[tweet.length()];
    for (int j = 0; j < tweet.length(); j++) {
      System.out.println("j = " + j);
      letters[j] = new Letter(x,100,tweet.charAt(j), random(20,30)); 
      x += textWidth(tweet.charAt(j)) + 3;
    }
  
    // Display each letter for the current tweet
    for (int k = 0; k < letters.length; k++) {
      System.out.println("k = " + k);
      // Display all letters
      letters[k].display();
//      System.out.println("displaying " + letters[k].getLetter());
      // Move the letters so they scroll across the screen
      float oldX = letters[k].getX();
      // Increase the subtracted number to speed up scrolling
      float newX = (oldX - 2);
      letters[k].setX(newX);
    
      // If the mouse is pressed the letters shake
      // If not, they return to their original location
      if (keyPressed) {
        letters[k].shake();
      } 
      else {
        letters[k].home();
      }
    }
  }
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

// A class to describe a single Letter
class Letter {
  char letter;
  // The default y position
  float homey;
  // Current location
  float x,y;
  float textSize;

  Letter (float x_, float y_, char letter_, float textSize_) {
    x = x_;
    homey = y = y_;
    letter = letter_; 
    textSize = textSize_;
  }

  // Display the letter
  void display() {
    int colour = colours[(int)random(5)];
    canvas.fill(colour);
    canvas.textFont(fonts[(int)random(3)], textSize);
    canvas.textAlign(LEFT);
    //put letter on screen
    canvas.text(letter,x,y);
  }
  
  float getX() {
   return this.x; 
  }
  char getLetter() {
   return this.letter; 
  }

  void setX(float newX) {
   x = newX; 
  }

  // Move the letter randomly up and down
  void shake() {
    y += random(-2,2);
  }

  // Return the letter to its default y position
  void home() {
    y = homey; 
  }
}
