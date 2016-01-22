import processing.serial.*;
import processing.opengl.*;
import jmcvideo.*;
import javax.media.opengl.*; 
import pitaru.sonia_v2_9.*;
import fullscreen.*;
import japplemenubar.*;

final int APPROACHING = 1;
final int SITTING = 2;
final int SITTING_FRONT = 3;
final int SITTING_BACK = 4;
final int TURNING = 5;
final int GO_LEFT = 6;
final int GO_RIGHT = 7;

int STATE = 0;

Serial serialPort;
String dataBuffer = "";
int previousData = 300;
boolean dataComing = false;

JMCMovieGL moviePlayer;
int pvw, pvh;

FullScreen fs;

Sample musicPlayer;
String[] musics = new String[]
                {
                  "sound_mute.wav"
                };
int musicIndex = 0;

ChairState chairState;

int approachingTreshold = 0;
int approachingTresholdLimit = 500;

int turningTreshold = 0; 
int turningTresholdLimit = 250; 

int sittingTreshold = 0;
int sittingTresholdLimit = 500;

int sittingFrontTreshold = 0;
int sittingFrontTresholdLimit = 250;

int sittingBackTreshold = 0;
int sittingBackTresholdLimit = 250;

int goRightTreshold = 0;
int goRightTresholdLimit = 500;

int goLeftTreshold = 0;
int goLeftTresholdLimit = 500;

int sittingRightTreshold = 0;
int sittingRightTresholdLimit = 500;

int sittingLeftTreshold = 0;
int sittingLeftTresholdLimit = 500;



void setup() 
{
  chairState = ChairState.Approaching;
  
  String portName = Serial.list()[0];
  serialPort = new Serial(this, portName, 9600);
  
  size(screen.width, screen.height, OPENGL);
  frame.setResizable(true);
  background(0);
  
  //fs = new FullScreen(this);
  //fs.enter();
  
  Sonia.start(this);
  musicPlayer = new Sample("sound_mute.aiff");
  musicPlayer.repeat();
  musicPlayer.setVolume(0.0f);

  moviePlayer = movieFromDataPath(chairState.getApproachingVideo()); 
  moviePlayer.loop();
}

void draw()
{
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;

  GL gl = pgl.beginGL();  
  {
    if (pvw != width || pvh != height)
    {
      background(0);
      gl.glViewport(0, 0, width, height);
      pvw = width;
      pvh = height;
    }
    moviePlayer.frameImage(gl);
  }
  pgl.endGL();
}

void serialEvent(Serial myPort)
{
  char data = myPort.readChar();
  if(data == '#')
  {
    dataComingStart();
  }
  else if (data == '!')
  {
    dataComingEnd();
  }
  else if(data == 'R' || data == 'L' || data == 'T' || data == 'S' || data == 'B' || data == 'F')
  {
    changeCurrentVideo(data);
  }
  else
  {
    if(dataComing)
    {
      char c[] = {data};
      String a = new String(c);
      dataBuffer += a;
    }
  }
}

void changeCurrentVideo(char side)
{ 
  if(side == 'R')
  {
    if(sittingRightTreshold >= sittingRightTresholdLimit)
    {
      if(sittingRightTreshold > sittingRightTresholdLimit)
        sittingRightTreshold = sittingRightTreshold;
        
      sittingLeftTreshold = 0;
      sittingFrontTreshold = 0;
      approachingTreshold = 0;
      turningTreshold = 0; 
      sittingTreshold = 0;
      sittingBackTreshold = 0;
      goRightTreshold = 0;
      goLeftTreshold = 0;
    
    
      if(chairState != ChairState.GoRight)
      {     
        if(musicPlayer != null && musicPlayer.isPlaying())
          musicPlayer.stop();
        chairState = ChairState.GoRight;
        int randomNumber = int(random(4));
        String video = chairState.getRightLeftVideo(randomNumber);
        moviePlayer.switchVideo(video); 
        moviePlayer.loop();
      }
    }
    else
      ++sittingRightTreshold;
  }
  
  else if(side == 'L')
  {
    if(sittingLeftTreshold > sittingLeftTresholdLimit)
    {
      if(sittingLeftTreshold > sittingLeftTresholdLimit)
        sittingLeftTreshold = sittingLeftTresholdLimit;
        
      sittingRightTreshold = 0;
      sittingFrontTreshold = 0;
      approachingTreshold = 0;
      turningTreshold = 0; 
      sittingTreshold = 0;
      sittingBackTreshold = 0;
      goRightTreshold = 0;
      goLeftTreshold = 0;
    
    
      if(chairState != ChairState.GoLeft)
      {
        if(musicPlayer != null && musicPlayer.isPlaying())
          musicPlayer.stop();
        chairState = ChairState.GoLeft;
        int randomNumber = int(random(4));
        String video = chairState.getRightLeftVideo(randomNumber);
        moviePlayer.switchVideo(video); 
        moviePlayer.loop();
      }
    }
    else
      ++sittingLeftTreshold;
  }
  
  else if(side == 'T')
  {
    if(turningTreshold > turningTresholdLimit)
    {
      if(turningTreshold > turningTresholdLimit)
        turningTreshold = turningTresholdLimit;
        
      sittingRightTreshold = 0;
      sittingLeftTreshold = 0;
      sittingFrontTreshold = 0;
      approachingTreshold = 0;
      sittingTreshold = 0;
      sittingBackTreshold = 0;
      goRightTreshold = 0;
      goLeftTreshold = 0;
    
      if(chairState != ChairState.Turning)
      {     
        if(musicPlayer != null && musicPlayer.isPlaying())
          musicPlayer.stop();
        chairState = ChairState.Turning;
        int randomNumber = int(random(2));
        String video = chairState.getTurningVideo(randomNumber);
        moviePlayer.switchVideo(video); 
        moviePlayer.loop();
      }
    }
    else
      ++turningTreshold;
  }
  
  else if(side == 'S')
  {
    if(sittingTreshold > sittingTresholdLimit)
    {
      if(sittingTreshold > sittingTresholdLimit)
        sittingTreshold = sittingTresholdLimit;
      sittingRightTreshold = 0;
      sittingLeftTreshold = 0;
      sittingFrontTreshold = 0;
      approachingTreshold = 0;
      turningTreshold = 0; 
      sittingBackTreshold = 0;
      goRightTreshold = 0;
      goLeftTreshold = 0;
    
      if(chairState != ChairState.Sitting)
      {     
        if(musicPlayer != null && musicPlayer.isPlaying())
          musicPlayer.stop();
        chairState = ChairState.Sitting;
        if(!moviePlayer.isPlaying())
        {
          moviePlayer.switchVideo(chairState.getApproachingVideo()); 
          moviePlayer.loop();
        }
      }
    }
    else
      ++sittingTreshold;
  }
 
  else if(side == 'B')
  {
    if(sittingBackTreshold > sittingBackTresholdLimit)
    {
      if(sittingBackTreshold > sittingBackTresholdLimit)
        sittingBackTreshold = sittingBackTresholdLimit;
    
      sittingRightTreshold = 0;
      sittingLeftTreshold = 0;
      sittingFrontTreshold = 0;
      approachingTreshold = 0;
      turningTreshold = 0; 
      sittingTreshold = 0;
      goRightTreshold = 0;
      goLeftTreshold = 0;
    
      if(chairState != ChairState.SittingBack)
      {     
        if(musicPlayer != null && musicPlayer.isPlaying())
          musicPlayer.stop();
        chairState = ChairState.SittingBack; 
        int randomNumber = int(random(4));
        String video = chairState.getSittingBackVideo(randomNumber);
        moviePlayer.switchVideo(video); 
        moviePlayer.loop();
      }
    }
    else
      ++sittingBackTreshold;
  }
  
  else if(side == 'F')
  {
    if(sittingFrontTreshold > sittingTresholdLimit)
    {
      if(sittingFrontTreshold > sittingTresholdLimit)
        sittingFrontTreshold = sittingTresholdLimit;
      sittingRightTreshold = 0;
      sittingLeftTreshold = 0;
      approachingTreshold = 0;
      turningTreshold = 0; 
      sittingTreshold = 0;
      sittingBackTreshold = 0;
      goRightTreshold = 0;
      goLeftTreshold = 0;
    
      if(chairState != ChairState.SittingFront)
      {     
        if(musicPlayer != null && musicPlayer.isPlaying())
          musicPlayer.stop();
        chairState = ChairState.SittingBack;
        
        int randomNumber = int(random(5));
        String video = chairState.getSittingFrontVideo(randomNumber);
        moviePlayer.switchVideo(video); 
        moviePlayer.loop();
      }
    }
    else
      ++sittingFrontTreshold;
  }
  else
    ;
}

void dataComingStart()
{
  dataBuffer = "";
  dataComing = true;
}

void dataComingEnd()
{
  dataComing = false;
  getData();
}

void getData()
{
  String temp = dataBuffer.trim();
  int value = int(temp);// % 300;
  if(value > 10)
    value = 10;
    
    
    if(approachingTreshold > approachingTresholdLimit)
    {
      if(approachingTreshold > approachingTresholdLimit)
        approachingTreshold = approachingTresholdLimit;
      
      if(chairState != ChairState.Approaching)
      {
        turningTreshold = 0; 
        sittingTreshold = 0;
        sittingFrontTreshold = 0;
        sittingBackTreshold = 0;
        goRightTreshold = 0;
        goLeftTreshold = 0;
        sittingLeftTreshold = 0;
      
        chairState = ChairState.Approaching;
        String video = chairState.getApproachingVideo();
        moviePlayer.switchVideo(video); 
        moviePlayer.loop();
      }
      
      if(chairState == ChairState.Approaching)
      {
        if(musicPlayer != null)
        {
          if(!musicPlayer.isPlaying())
            musicPlayer.repeat();  
            
          
          if(value == 10)
            musicPlayer.setVolume(1.0f);
          else if(value == 9)
            musicPlayer.setVolume(0.9f);
          else if(value == 8)
            musicPlayer.setVolume(0.8f);
          else if(value == 7)
            musicPlayer.setVolume(0.7f);
          else if(value == 6)
            musicPlayer.setVolume(0.6f);
          else if(value == 5)
            musicPlayer.setVolume(0.5f);
          else if(value == 4)
            musicPlayer.setVolume(0.4f);
          else if(value == 3)
            musicPlayer.setVolume(0.3f);
          else if(value == 2)
            musicPlayer.setVolume(0.2f);
          else if(value == 1)
            musicPlayer.setVolume(0.1f);
          else if(value == 0)
            musicPlayer.setVolume(0.0f);
          else
            ;
        }
    }
    else
      ++approachingTreshold;
    
    dataBuffer = "";
}
}

JMCMovieGL movieFromDataPath(String filename)
{
  return new JMCMovieGL(this, filename, RGB);
}

