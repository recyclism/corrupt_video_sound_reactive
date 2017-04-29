/*
Corrupt.video + OpenCV Face Tracking = FaceGLitching
Made with Processing by Recyclism aka Benjamin Gaulon
Paris. May 2014.
Fill free to use / hack / modify this code
*/

import ddf.minim.*;

Minim minim;
AudioInput in;


import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

PImage photo;
PImage faceSave;

void setup() {
  background(0);
  size(640, 480);

  video = new Capture(this, width, height);
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
  
   minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

void draw() {
  scale(1);

  image(video, 0, 0 );
  noFill();
  noStroke();
  strokeWeight(1);
 
  

 

    photo = loadImage("partialSave.jpg");
    rect(0, 0, width, height);
   
   PImage partialSave = get(0, 0, width, height);
  
   partialSave.save("partialSave.jpg");
  
 
   byte b[] = loadBytes("partialSave.jpg");
   
   // glitch faces
   
     byte bCopy[] = new byte[b.length];
     arrayCopy(b, bCopy);
     // load binary of file

     int scrambleStart = 10;
     // scramble start excludes 10 bytes///
     
     int scrambleEnd = b.length;
     // scramble end ///
     
       for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
    
         int nbOfReplacements = int (in.left.get(i)*50);
println(in.left.get(i)*50);
 for(int g = 0; g < nbOfReplacements; g++)

     {
       int PosA = int(random (scrambleStart, scrambleEnd));

       int PosB = int(random (scrambleStart, scrambleEnd));

       byte tmp = bCopy[PosA];

       bCopy[PosA] = bCopy[PosB];

       bCopy[PosB] = tmp;

    saveBytes("partialSave.jpg", bCopy);
     }
  }
     
     // Number of Replacements - Go easy with this as too much will just kill the file ///

     // Swap bits ///
    

    
  image(photo, 0, 0, width, height );
 
 
 
}

void captureEvent(Capture c) {
  c.read();
}