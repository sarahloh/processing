import org.java_websocket.handshake.*;
import org.java_websocket.server.*;
import org.java_websocket.exceptions.*;
import org.java_websocket.*;
import org.java_websocket.client.*;
import org.java_websocket.drafts.*;
import org.java_websocket.framing.*;
import org.java_websocket.util.*;

import java.net.URI;
import java.net.URISyntaxException;

import org.java_websocket.client.WebSocketClient;
import org.java_websocket.drafts.Draft;
import org.java_websocket.drafts.Draft_10;
import org.java_websocket.framing.Framedata;
import org.java_websocket.handshake.ServerHandshake;

//SYPHON
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
String[] headlines = {
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
PFont f; // Global font variable
float x; // Horizontal location
int index = 0;
//END

private WebSocketClient cc;
void setup(){
  
  size(500,100, P3D);
  canvas = createGraphics(500, 100, P3D);
  f = createFont( "Arial" ,16,true);
  x = width;
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");

  try{
  // more about drafts here: http://github.com/TooTallNate/Java-WebSocket/wiki/Drafts
  cc = new WebSocketClient( new URI( "ws://localhost:4000" ), new Draft_10() ) {
    @Override
    public void onMessage( String message ) {
      System.out.println("received " + message);
    }
    @Override
    public void onOpen( ServerHandshake handshake ) {
      System.out.println("opened");
    }
    @Override
    public void onClose( int code, String reason, boolean remote ) {
 
    }
    @Override
    public void onError( Exception ex ) {
 
    }
  };
  cc.connect();
  //cc.send("test");
  } 
  catch(Exception e){
    print(e);
  }
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);
  canvas.fill(110, 220, 240);
  canvas.textFont(f,16);
  canvas.textAlign (LEFT);
  // A specific String from the array is displayed according to the value of the "index" variable.
  canvas.text(headlines[index],x,55); 
  // Decrement x
  x = x - 2;
  // If x is less than the negative width, then it is off the screen
  // textWidth() is used to calculate the width of the current String.
  float w = textWidth(headlines[index]); 
  if (x < -w) {
    x = width;
    // index is incremented when the current String has left the screen in order to display a new String.
    index = (index + 1) % headlines.length; 
  }
  
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

