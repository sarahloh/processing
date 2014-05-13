//http://www.interactiondesign.se/wiki/courses:intro.prototyping.fall.2012.dec13

//My demo example 

import processing.video.*;
int example = 1;
float recent, old;
float opacNum = 0.0, line1 = 0.0;
Capture cam;
PFont myFont;
PImage ghoul;
 
void setup() {
  size(640, 480);
  old = millis();
  myFont = createFont("Georgia", 32);
  textFont(myFont);  
  stroke(0);
  ghoul = loadImage("bird.jpg");
  String[] cameras = Capture.list();
 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
 
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    //cam = new Capture(this, cameras[3]); //inPersonHD
    cam = new Capture(this, cameras[0]); //inbyggd
    cam.start();
  }
}
 
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
 
//default
  if (example == 1)
  {
    noTint();
    image(cam, 0, 0);
  }
//tint  
  else if (example == 2)
  {
    tint(0, 153, 204);
    image(cam, 0, 0);
  }
//filter
  else if (example == 3)
  {
    noTint();
    image(cam, 0, 0);
    filter(INVERT);
  }
//tint as semi-transparency  
  else if (example == 4)
  {
    background(0);
    tint(255, 50);
    image(ghoul, 0, 0, 640, 480);
    image(cam, 0, 0);
  }
//drawing the cam-feed image twice but smaller  
  else if (example == 5)
  {
    background(0);
    noTint();
    image(cam, 0, 0, 320, 240);
    image(cam, 320, 240, 320, 240);
  }
//Andy warhol mode
  else if (example == 6)
  {
    tint(100, 200, 100);
    image(cam, 0, 0, 320, 240);
    noTint();
    image(cam, 0, 240, 320, 240);
    tint(200, 100, 100);  
    image(cam, 320, 0, 320, 240);
    tint(100, 100, 200);  
    image(cam, 320, 240, 320, 240);
  }
//Ye olde webcam (moving Y coordinate, moving black line, 
//changing opacity w tint and grayscale w filter
  else if (example == 7)
  {
    recent  = millis();
    if (recent - old > 100)
    {
      background(0);
      stroke(0);
      strokeWeight(1);
      opacNum = opacNum + .08;
      float n = noise(opacNum) * 512;
 
      // Draw the image to the screen at coordinate (0,0)
      tint(n);
      println(n);
      image(cam, 80, (n/10)+60, 480, 360);
      filter(GRAY);
 
      //First wandering line
      line1 = line1 + .08;
      n = noise(line1) * 640;    
      //println(n);
      line(n, 0, n, height);   
      old = recent;
      //saveFrame("output-####.png");  //saving frames to files
    }
  }
//putting graphics and text on top of the cam-feed  
  else if (example == 8)
  {
    stroke(#5555FF);
    strokeWeight(3);
    fill(#5555FF);
    textSize(20);
    image(cam, 0, 0);
    line(20, 20, 20, 460);
    line(20, 460, 620, 460);
    for (int i = 20; i < 460; i+=10)
      line(20, i, 40, i);
    for (int i = 50; i < 600; i+=50)
      line(i, 460, i, 440);
    strokeWeight(1);
    text("target in range", 45, 400);
    String value = str(random(1000, 2000));
    text(value, 500, 40);
 
    line(0, mouseY, 640, mouseY);
    line(mouseX, 0, mouseX, 480);
  }
//copying strips out of the cam-feed image
//and drawing them in another order.
  else if (example == 9)
  {
    background(0);
    loadPixels();
    cam.loadPixels();
    if (cam.pixels.length > 0)
    {
      //second
      for (int X = 0; X < 128; X++) {
        // Loop through every pixel row
        for (int Y = 0; Y < height; Y++) {
          // Use the formula to find the 1D location
          int loc = X + Y * width;
          int loc2 = X+127 + Y * width;
          // If we are an odd column
          pixels[loc2] = cam.pixels[loc];
        }
      }
      //fifth
      for (int X = 129; X < 256; X++) {
        // Loop through every pixel row
        for (int Y = 0; Y < height; Y++) {
          // Use the formula to find the 1D location
          int loc = X + Y * width;
          int loc2 = X+380 + Y * width;
          // If we are an odd column
          pixels[loc2] = cam.pixels[loc];
        }
      }
      //fourth
      for (int X = 257; X < 384; X++) {
        // Loop through every pixel row
        for (int Y = 0; Y < height; Y++) {
          // Use the formula to find the 1D location
          int loc = X + Y * width;
          int loc2 = X+125 + Y * width;
          // If we are an odd column
          pixels[loc2] = cam.pixels[loc];
        }
      }
      //1st
      for (int X = 385; X < 512; X++) {
        // Loop through every pixel row
        for (int Y = 0; Y < height; Y++) {
          // Use the formula to find the 1D location
          int loc = X + Y * width;
          int loc2 = X-385 + Y * width;
          // If we are an odd column
          pixels[loc2] = cam.pixels[loc];
        }
      }
      //3rd
      for (int X = 513; X < 640; X++) {
        // Loop through every pixel row
        for (int Y = 0; Y < height; Y++) {
          // Use the formula to find the 1D location
          int loc = X + Y * width;
          int loc2 = X-258 + Y * width;
          // If we are an odd column
          pixels[loc2] = cam.pixels[loc];
        }
      }
    }
 
    //println(cam.pixels.length);
    //image(result, 0, 0);
  }
//looking at one pixel and reacting to if it's dark
//(= blue value is lower than 50)  
  if (example == 10)
  {
    stroke(#5555FF);
    strokeWeight(3);
    noFill();  
    noTint();
    cam.loadPixels();    
    if (cam.pixels.length > 0)
    {
 
      int loc = 20 + 20*width;
      float b = blue(cam.pixels[loc]);
      image(cam, 0, 0);
      rect(10, 10, 20, 20);    
      if (b < 50)
      {
        println("Dark");
        fill(#5555FF);
        textSize(40);
        text("Black detected!", 250, 240);
      }
 
      //println(r);
    }
  }
 
 
  //image(cam, 0, 0);
}
 
void keyPressed()
{
  if (key == '1')
    example = 1;
  if (key == '2')
    example = 2;
  if (key == '3')
    example = 3;
  if (key == '4')
    example = 4;
  if (key == '5')
    example = 5;
  if (key == '6')
    example = 6;
  if (key == '7')
    example = 7;    
  if (key == '8')
    example = 8;
  if (key == '9')
    example = 9;
  if(key == 'q')
    example = 10;
}
