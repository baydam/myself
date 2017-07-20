/*
* Author: Bay Dam
* License: public domain
* Date: Juin 2017
*/

// Import library for video export
import com.hamoid.*;
// Create differents images ie: red, green and blue
PImage redImage, greenImage, blueImage;
// Create video export object
VideoExport videoExport;
// By default recording mode is disable
boolean recording = false;

void setup() {
  size(600, 600);
  // Load red imaage and resize it
  redImage = loadImage("red.png");
  redImage.resize(0, 400);
  // Load green imaage and resize it
  greenImage = loadImage("green.png");
  greenImage.resize(0, 400);
  // Load blue imaage and resize it
  blueImage = loadImage("blue.png");
  blueImage.resize(0, 400);
  // Set the images position from the center
  imageMode(CENTER);
  // Configure the video exporter
  videoExport = new VideoExport(this, "myself.mp4");
  // The standard frame rate for internet videos is about
  // 30 frames per second
  videoExport.setFrameRate(30);
  videoExport.startMovie();

  // By default Processing tries to play at 60 frames
  // per second. That means that your exported videos
  // may feel slow, as they are played at half the
  // speed of the original. You may want to play your
  // sketch at 30 fps too, so the sketch and the video
  // run at similar frame rates. To compensate for the
  // lower frame rate you may have to adjust your sketch
  // to make your objects move faster.
  frameRate(30);
}

void draw() {
  // Set background to white
  background(255);
  // Width divide by two
  float centerX = width / 2;
  // Height divide by two
  float centerY = height / 2;
  // Mouse position minus previous mouse position for X and Y
  float dmouseX = mouseX - pmouseX;
  float dmouseY = mouseY - pmouseY;
  // Draw red image and make it move to the opposite direction of the mouse
  drawImage(redImage, centerX - dmouseX, centerY - dmouseY);
  // Draw red image and keep it to the center
  drawImage(greenImage, centerX, centerY);
  // Draw red image and make it move to the direction of the mouse
  drawImage(blueImage, centerX + dmouseX, centerY + dmouseY);
  // if recording mode is acticated start to save frames
  if(recording) {
    videoExport.saveFrame();
  }
}

void drawImage(PImage img, float x, float y) {
  int imgWidth = img.width;
  int imgHeight = img.height;
  // Blends a region of pixels from one image into another with full alpha channel support
  blend(img, 0, 0, imgWidth, imgHeight, int(x - 0.5 * imgWidth), int(y - 0.5 * imgHeight), imgWidth, imgHeight, SUBTRACT);
}

void keyPressed() {
  // Press r ou R to switch recording mode ON/OFF
  if(key == 'r' || key == 'R') {
    recording = !recording;
    println("Recording is " + (recording ? "ON" : "OFF"));
  }
  // Press q to finish the record
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
