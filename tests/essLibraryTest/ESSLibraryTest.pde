import krister.Ess.*;

AudioChannel myChannel;
FFT myFFT;

int bufferSize;
int bufferDuration;


void setup()
{
  size(256,200);

  // start up Ess

  Ess.start(this);

  myChannel=new AudioChannel("pic.mp3");
  bufferSize=myChannel.buffer.length;
  bufferDuration=myChannel.ms(bufferSize);

  noSmooth();
  
  myChannel.play(Ess.FOREVER);
}

void draw() {
  
}

void mousePressed() {
  myChannel.volume(1.0f);
}

void keyPressed()
{
  switch(key)
  {
    case '0':
      myChannel.volume(0.0f);
      break;
    case '1':
      myChannel.volume(0.1f);
      break;
    case '2':
      myChannel.volume(0.2f);
      break;
    case '3':
      myChannel.volume(0.3f);
      break;
    case '4':
      myChannel.volume(0.4f);
      break;
    case '5':
      myChannel.volume(0.5f);
      break;
    case '6':
      myChannel.volume(0.6f);
      break;
    case '7':
      myChannel.volume(0.7f);
      break;
    case '8':
      myChannel.volume(0.8f);
      break;
    case '9':
      myChannel.volume(0.9f);
      break;
    default:
      myChannel.volume(1.0f);
      break;
  }
}

// clean up Ess before exiting

public void stop() {
  Ess.stop();
  super.stop();
}


