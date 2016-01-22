import pitaru.sonia_v2_9.*;

Sample mySample;

void setup()
{
  size(100, 100);
  Sonia.start(this); // Start Sonia engine.
  mySample = new Sample("pic.aiff");
  mySample.repeat();
}

void draw(){
  
}

void keyPressed()
{
  switch(key)
  {
    case '0':
      mySample.setVolume(0.0f);
      break;
    case '1':
      mySample.setVolume(0.1f);
      break;
    case '2':
      mySample.setVolume(0.2f);
      break;
    case '3':
      mySample.setVolume(0.3f);
      break;
    case '4':
      mySample.setVolume(0.4f);
      break;
    case '5':
      mySample.setVolume(0.5f);
      break;
    case '6':
      mySample.setVolume(0.6f);
      break;
    case '7':
      mySample.setVolume(0.7f);
      break;
    case '8':
      mySample.setVolume(0.8f);
      break;
    case '9':
      mySample.setVolume(0.9f);
      break;
    default:
      mySample.setVolume(1.0f);
      break;
  }
}
           
void mousePressed(){

}

void mouseReleased(){
  // Stop the sample, and unload it form memory in 1 frames (each frame is about 1 ms).
  mySample.stop(1);
}

// NOT IN USE FOR THIS EXAMPLE
void setVolume(){
  // set the volume of the sample. 
  // Range: float from 0 to 1 
  float vol = mouseY/(height*1f);
  mySample.setVolume(vol);
}

// Safely close the sound engine upon Browser shutdown.
public void stop(){
  Sonia.stop();
  super.stop();
}
   
