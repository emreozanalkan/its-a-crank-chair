import processing.video.*;

import fullscreen.*;
import japplemenubar.*;

Capture capture;

FullScreen fs;

int captureWidth, captureHeight;

void setup()
{
  size(1440, 900);
  
  fs = new FullScreen(this);
  fs.enter();
  
  println(Capture.list());
  
  //capture = new Capture(this, width, height, 30);
  capture = new Capture(this, width, height, "USB Video Class Video", 30);
  
  captureWidth = capture.width / 2;
  captureHeight = capture.height / 2;
  
  background(0, 0, 0);
}

void captureEvent(Capture capture) {
  capture.read();
}

void draw()
{
  translate(captureWidth, captureHeight);
  rotate(-HALF_PI);
  translate(-captureWidth, -captureHeight);
  image(capture, 0, 0);
}


