/* 
   SparkFun SIKIO - Quickstart
   Hardware Concept: Digital Out
   Android Concept: Draw Box 
   CC BY-SA, http://creativecommons.org/licenses/by-sa/3.0/
   
   PURPOSE:
   This example shows how the main Processing file (in this case, SIKIO_C0_quickstart.pde)
   and the IOIOThread.pde file interact through the use of a global variable. The main .pde 
   file controls the user interface and the IOIOThread.pde controls the IOIO board. 
   
   HARDWARE:
   This is an example that doesn't require anything other than your Android and a IOIO.
   
   OPERATION:
   The sketch starts by running IOIOThread.pde. In the thread, a flag is set through the 
   global variable 'lightON', when the LED turns on and off. This global variable is read in 
   the code below and a black or white box is drawn depending on the state of the LED.
*/

//Import the IOIO libraries. If you want to interact with the IOIO board, you must 
//include all of these files. These come from the IOIO folder in your Processing ->
//libraries directory.
import ioio.lib.util.android.*;
import ioio.lib.spi.*;
import ioio.lib.util.*;
import ioio.lib.impl.*;
import ioio.lib.api.*;
import ioio.lib.api.exception.*;

//Create a IOIO instance. This is the entry point to the IOIO API. It creates the
//bootstrapping between a specific implementation of the IOIO interface and any
//dependencies it might have, such as the underlying connection logic.
IOIO ioio = IOIOFactory.create();

//Create an instance of our IOIOThread class. The thread code is found in IOIOThread.pde. The 
//thread runs independently of the main sketch below.
IOIOThread thread1; 

//This ia a boolean variable that reads if the LED is on or off. The variable can be
//used in this file or the IOIOThread.pde file. 
boolean lightOn = false;

//Main setup function; this is run once and is generally used to initialize things. 
void setup() {
  
  //Instantiate our thread, with a thread id of 'thread1' and a wait time of 100 milliseconds.
  //The wait time is the time in between interations of the thread.  
  thread1 = new IOIOThread("thread1", 100);
  //Start our thread.
  thread1.start();
  
  //Lock screen in portrait mode.
  orientation(PORTRAIT); 
  
  //Drawing options.
  smooth(); //anti-aliased edges, creates smoother edges
  noStroke(); //disables the outline
  rectMode(CENTER); //place rectangles by their center coordinates, (the default is the TL corner)
  
  //Paint background color.
  background(255,0,0);//red
}

//Main draw loop is repeated 60 times a second. 
void draw() {

  //If LED is ON, draw a black rectangle.
  if (lightOn == true) {
    fill(0); //draw black
    //The values of the horizontal and verticle resoultions of your display are found in the width
    //and height variables. Be sure to scale your objects as a ratio of width and height, so that 
    //if you use another size display, your objects won't be outside of the viewable area.    
    rect(width/2, height/2, 100, 100); //draw rectangle
  }
  //If LED is OFF, draw a white rectangle.
  else if (lightOn == false) { 
    fill(255); //draw white
    rect(width/2, height/2, 100, 100); //draw rectangle
  }
}