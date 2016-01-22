import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import fullscreen.*;
import japplemenubar.*;
import processing.video.*;
 
// Put here your local video files or full paths
String movies[] = {"1.mov", "2.mov", "3.mov"};
int movieIndex;

FullScreen fs;
Movie movie;

Minim minim;
AudioPlayer player;

void setup()
{
  size(screen.width, screen.height, P2D);
  
  frameRate(30);

  // Create the fullscreen object
  fs = new FullScreen(this); 
  
  // enter fullscreen mode
  fs.enter(); 
  
  movieIndex = 0;
  
  movie = new Movie(this, "1.mov");
  movie.loop();
  
  minim = new Minim(this);
  // load a file, give the AudioPlayer buffers that are 2048 samples long
  player = minim.loadFile("deneme.mp3", 2048);
  // play the file
  player.play();
}

void draw()
{
  //tint(255, 20);
  //image(movie, 0, 0);
  image(movie, 0, 12, screen.width, screen.height - 12);
}

void movieEvent(Movie m) {
    m.read();
}

void keyPressed()
{
  movie.noLoop();
  movie.stop();
  movieIndex = (++movieIndex) % 3;
  movie = null;
  movie = new Movie(this, movies[movieIndex]); 
  movie.loop();
}

void stop()
{
  //Serial.println("Hehe");
}








