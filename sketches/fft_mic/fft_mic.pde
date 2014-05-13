
// Fancy FFT of the song
// Erin K 09/20/08
// RobotGrrl.com
// ------------------------
// Based off the code by Tom Gerhardt
// thomas-gerhardt.com


import processing.core.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

Minim minim;
AudioPlayer player;
AudioInput input;
FFT fftLog;

int lastPosition;
int canvasW = 1024;
int canvasH = 600;
int baseLine = 700;
int sampleCount = 0;
int sizew = 20;
int sizeh = 15;

void setup() {
  size(canvasW, canvasH, P3D);
  background(0);
  minim = new Minim(this);
  player = minim.loadFile("song.mp3");
  input = minim.getLineIn();
  //Minim.start(this);

//  fftLog = new FFT(player.bufferSize(), player.sampleRate());
  fftLog = new FFT(input.bufferSize(), input.sampleRate());
  fftLog.logAverages(22, 3);
  fftLog.window(FFT.HAMMING);
  player.loop();
  colorMode(HSB, 100);
  
  canvas = createGraphics(canvasW, canvasH, P3D);
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  canvas.beginDraw();
  if (player.isPlaying() && player.position() != lastPosition) {
    lastPosition = player.position();
    fftLog.forward(player.mix);
    canvas.ellipseMode(CENTER);
    canvas.smooth();
    canvas.noStroke();
    canvas.colorMode(HSB, 100);

    for (int i = 0; i < fftLog.avgSize(); i++) {         
      if (i < fftLog.avgSize() - 29) {
        canvas.fill(color(0, 0, 0, 20));
        canvas.rect(0, 0, canvasW, canvasH);
      }

      float amp = sqrt(sqrt(fftLog.getAvg(i)))*150;
      float h = i * 100/fftLog.avgSize();
      h -= 10;
      h = 100 - h;
      float s = 70;
      float b = amp/3 * 100;
      float a = 100;
      canvas.fill(color(h, s, b, a));

      float x = i*24 + 150;
      float y = canvasH - amp-50;
      canvas.ellipse(x, y, sizew, sizeh);
    }
  }
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

void stop()
{
  player.close();
  super.stop();
}

