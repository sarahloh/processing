
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
AudioInput in;
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
  in = minim.getLineIn(Minim.STEREO, 512);
  minim.debugOn();

  fftLog = new FFT(in.bufferSize(), in.sampleRate());
  fftLog.logAverages(22, 3);
  fftLog.window(FFT.HAMMING);
  colorMode(HSB, 100);
  
  canvas = createGraphics(canvasW, canvasH, P3D);
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  canvas.beginDraw();
  fftLog.forward(in.mix);
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
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

void stop()
{
  in.close();
  minim.stop();
  super.stop();
}

