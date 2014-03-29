// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 17-3: Scrolling headlines 

// An array of news headlines
String[] headlines = {
  "RT @enekondesign: Iasi Palas Romania - Dec 2013 Video: https://t.co/y2AF8geEEt In the News: http://t.co/JIaYlzEIz8 #ProjectionMapping #Ro…",
  "Iasi Palas Romania - Dec 2013 Video: https://t.co/y2AF8geEEtIn the News: http://t.co/JIaYlzEIz8#ProjectionMapping #Romania",
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
  "Projection mapping sobre elementos móviles - #oldpost http://t.co/OuS8NP2d56\n #ProjectionMapping"
};

PFont f; // Global font variable
float x; // Horizontal location
int index = 0;

void setup() {
  size(400,400);
  f = createFont( "Arial" ,16,true);
  
  // Initialize headline offscreen
  x = width;
}

void draw() {
  background(255);
  fill(0);
  
  // Display headline at x location
  textFont(f,16);
  textAlign (LEFT);
  
  // A specific String from the array is displayed according to the value of the "index" variable.
  text(headlines[index],x,180); 
  
  // Decrement x
  x = x - 3;
  
  // If x is less than the negative width, then it is off the screen
  // textWidth() is used to calculate the width of the current String.
  float w = textWidth(headlines[index]); 
  if (x < -w) {
    x = width;
    // index is incremented when the current String has left the screen in order to display a new String.
    index = (index + 1) % headlines.length; 
  }
}
