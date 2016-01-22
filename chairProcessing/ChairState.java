public enum ChairState {
  Approaching (0), 
  Turning(1), 
  Sitting(2),
  SittingFront(3),
  SittingBack(4),
  GoRight(5),
  GoLeft(6);

  private final int index;

  String approachingVideo = new String("comp2.mov");
                
   String[] sittingRightLeft = new String[]
                {
                  "yan1.mov",
                  "yan2.mov",
                  "yan3.mov",
                };
  
  String sittingVideo = new String("comp2.mov");
  
  String[] sittingFrontVideos = new String[]
                {
                  "killfront.mov",
                  "charli1.mov",
                  "charli2.mov",
                  "matrix.mov",
                  "v_for_vendetta.mov"
                };
       
  String[] sittingBackVideos = new String[]
                {
                  "clockworkorange.mov",
                  "requem.mov",
                  "arka1.mov",
                  "matrixback.mov",
                  "metropolisback.mov"
                };
                
  String[] turningVideos = new String[]
                {
                  "donme1.mov",
                  "donme2.mov"
                };
                
  
  ChairState(int index){
    this.index = index;
  }
  
  String getApproachingVideo()
  {
    return approachingVideo;
  }
  
  String getRightLeftVideo(int index)
  {
    return sittingRightLeft[index];
  }
  
  String getSittingFrontVideo(int index)
  {
    return sittingFrontVideos[index];  // prints one of the four words
  }
  
  String getSittingBackVideo(int index)
  {
    return sittingBackVideos[index];  // prints one of the four words
  }
  
  String getTurningVideo(int index)
  {
    return turningVideos[index];
  }
  
}

