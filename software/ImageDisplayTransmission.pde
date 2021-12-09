/*
  This sketch reads a raw Stream of RGB565 pixels
  from the Serial port and displays the frame on
  the window.

  Use with the Examples -> CameraCaptureRawBytes Arduino sketch.

  This example code is in the public domain.
*/

import processing.serial.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.lang.*;
import java.util.concurrent.TimeUnit;

Serial myPort;

// must match resolution used in the sketch
final int cameraWidth = 320;
final int cameraHeight = 240;
final int cameraBytesPerPixel = 2;
final int bytesPerFrame = cameraWidth * cameraHeight * cameraBytesPerPixel;

PImage myImage;
byte[] frameBuffer = new byte[bytesPerFrame];

int num = 0;
double oldTime;

void setup()
{
  size(320, 240);
  
  num = 0;
  oldTime= 0;
  // if you have only ONE serial port active
  //myPort = new Serial(this, Serial.list()[0], 9600);          // if you have only ONE serial port active

  // if you know the serial port name
  myPort = new Serial(this, "COM4", 9600);                    // Windows
  //myPort = new Serial(this, "/dev/ttyACM0", 9600);            // Linux
  //myPort = new Serial(this, "/dev/cu.usbmodem14401", 9600);     // Mac

  // wait for full frame of bytes
  myPort.buffer(bytesPerFrame);  

  myImage = createImage(cameraWidth, cameraHeight, RGB);
}

void draw()
{
   
  image(myImage, 0, 0);
  double newTime = 0;
  String imageName = "image" + num + ".jpg";
  if (num%180 == 0){
    save(imageName);
    newTime = System.currentTimeMillis();
    System.out.print(newTime-oldTime);
    oldTime = newTime;
    System.out.print("\n");
    try{
    TimeUnit.SECONDS.sleep(5);
    }
    catch(InterruptedException ex)
    { ex.printStackTrace();
    }
  }
  num+=1;
}

void serialEvent(Serial myPort) {
  // read the saw bytes in
  myPort.readBytes(frameBuffer);

  // access raw bytes via byte buffer
  ByteBuffer bb = ByteBuffer.wrap(frameBuffer);
  bb.order(ByteOrder.BIG_ENDIAN);

  int i = 0;

  while (bb.hasRemaining()) {
    // read 16-bit pixel
    short p = bb.getShort();

    // convert RGB565 to RGB 24-bit
    int r = ((p >> 11) & 0x1f) << 3;
    int g = ((p >> 5) & 0x3f) << 2;
    int b = ((p >> 0) & 0x1f) << 3;

    // set pixel color
    myImage .pixels[i++] = color(r, g, b);
  }
 myImage .updatePixels();

}
