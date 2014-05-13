//http://www.stefhancaddick.co.uk/new/hive-2/motion-detection-with-processing-osc/

//code to pixellate video signal and send x,y value to Max/MSP. Largely based on code by Matt Jackson (http://jacksonmatt.wordpress.com/)

import processing.video.*;
//import oscP5.*; //we need this to communicate with MaxMSP
//import netP5.*; //we need this to communicate with MaxMSP

//OscP5 oscP5; //variable for MaxMSP Comms
//NetAddress myRemoteLocation; //variable for MaxMSP Comms

Capture video;
PImage backgroundImage;
PImage previousImage;

float threshold =  50; // adjust this to control sensitivity
int g = 1; //size of gaps between blocks
int bs = 20; // Size of blocks

int gs=g+bs;

void setup()  {
  size(640,480, P3D);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
//    cam = new Capture(this, cameras[0]);
//    cam.start();     
       
    video = new Capture(this, width, height, 30); 
    video.start();
    
    backgroundImage = createImage(video.width,video.height,RGB);
    previousImage = createImage(video.width,video.height,RGB); 

    background(0);
  }    

//  /* start oscP5, listening for incoming messages at port 5555 */
//  oscP5 = new OscP5(this,5555);
//
//  myRemoteLocation = new NetAddress("127.0.0.1",5555);
}   

void draw()
{
  background(0);

  if (video.available())
  {
    previousImage.copy(video,0,0,video.width,video.height,0,0,video.width,video.height);
    previousImage.updatePixels();

    video.read(); 

  }   

  loadPixels();
  video.loadPixels();
  backgroundImage.loadPixels();
  previousImage.loadPixels();

  for (int x =0; x < video.width; x++ ) {
    for (int y=0; y< video.height; y++ ){
      int loc =x + y*video.width; 

      color fgColor =video.pixels[loc];
      color pfColor = previousImage.pixels[loc];
      color bgColor=backgroundImage.pixels[loc]; 

      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);
      float diff = dist(r1,g1,b1,r2,g2,b2); 

      float r3 = red(pfColor);
      float g3 = green(pfColor);
      float b3 = blue(pfColor); 

      float diffmot = dist(r1,g1,b1,r3,g3,b3); 

      if (diff <  threshold )

      {
        pixels[loc] = 0;

      }
      if (diffmot>  threshold)  

      {
        if (loc%gs==0 &&  y%gs==0){
          fill(0,0,brightness(fgColor));
          rect(x ,y,bs,bs);

//          //send the pixel location to MaxMSP
//          OscMessage myMessage = new OscMessage( "processing" );
//        myMessage.add(new int[] {x, y}); 
//
//      // send the message
//        oscP5.send(myMessage, myRemoteLocation);
        }   

      }

    }
  }
  updatePixels(); 

}
