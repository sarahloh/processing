import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
PImage img;

void setup() {
size(500,450, P3D);
canvas = createGraphics(500, 450, P3D);
// Create syhpon server to send frames out.
server = new SyphonServer(this, "Processing Syphon");
img = loadImage("me.jpg");
}

void draw() {
canvas.beginDraw();
//canvas.background(100);
//canvas.stroke(255);
//canvas.line(50, 50, mouseX, mouseY);
canvas.image(img, 0, 0);
canvas.endDraw();
image(img, 0, 0);
server.sendImage(canvas);
}
