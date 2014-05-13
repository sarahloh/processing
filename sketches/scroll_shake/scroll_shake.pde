import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
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
PFont f1;
PFont f2;
PFont f3;// Global font variable
float x; // Horizontal location
int index = 0;
Letter[] letters;
int[] colours = {#2EB8E6, #33CCFF, #29A3CC, #248FB2, #47D1FF};
PFont[] fonts = {f1, f2, f3};

void setup() {
  size(500,100, P3D);
  canvas = createGraphics(500, 100, P3D);
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
  // Create the fonts
  fonts[0] = createFont("Ubuntu",20,true);
  fonts[1] = createFont("Ariel",20,true);
  fonts[2] = createFont("Franklin",20,true);
  x = width;
  setLettersArray();
}

void setLettersArray() {
  System.out.println("setting letts array for index " + index);
  String message = tweets[index];
   // Create the array the same size as the String
  letters = new Letter[message.length()];

  for (int i = 0; i < message.length(); i++) {
    letters[i] = new Letter(x,100,message.charAt(i), random(20,30)); 
    x += textWidth(message.charAt(i)) + 3;
    System.out.println("setting = " + i);
  } 
  System.out.println("letters contains: " + letters.toString());
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);
  canvas.fill(110, 220, 240);
  canvas.textFont(f1,16);
  canvas.textAlign (LEFT);
  // A specific String from the array is displayed according to the value of the "index" variable.
  canvas.text(tweets[index],x,55); 
  // Decrement x
  x = x - 3;
  // If x is less than the negative width, then it is off the screen
  // textWidth() is used to calculate the width of the current String.
  float w = textWidth(tweets[index]); 
  if (x < -w) {
    x = width;
    // index is incremented when the current String has left the screen in order to display a new String.
    index = (index + 1) % tweets.length; 
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
