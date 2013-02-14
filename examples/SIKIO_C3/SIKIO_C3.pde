/* 
   SparkFun SIKIO - Circuit 3
   Hardware Concept: PWM output
   Android Concept: position of touch presses
   CC BY-SA, http://creativecommons.org/licenses/by-sa/3.0/
   
   PURPOSE:
   This example shows how to play sounds from a piezo speaker using a PWM output on the IOIO. The sounds are generated by 
   touch events on a drawn paino keyboard. 
   
   HARDWARE:
   -piezo speaker
   
   OPERATION: 
   Plug the speaker into pin 11 on the IOIO. When the app opens, you should see a piano keyboard. Hit different 
   white keys to play different notes. The black keys do not generate any sound, we will leave that up to you to figure out.
*/

//Import the APWidgets library.
import apwidgets.*;

//Import IOIO library - this is from the link in the install section of your SIKIO guide.
import ioio.lib.util.android.*;
import ioio.lib.spi.*;
import ioio.lib.util.*;
import ioio.lib.impl.*;
import ioio.lib.api.*;
import ioio.lib.api.exception.*;

import android.view.MotionEvent; 

//Create a IOIO instance.
IOIO ioio = IOIOFactory.create();

//Create a thread for our IOIO code.
IOIOThread thread1; 

//Make a widget container and 8 buttons. Each button will play a note.
APWidgetContainer widgetContainer; 
APButton c;
APButton d;
APButton e;
APButton f;
APButton g;
APButton a;
APButton b;
APButton c2;

boolean ioio_good = false;

//Main setup function; this is run once and is generally used to initialize things. 
void setup() {

  //Instantiate our thread, with a thread id of 'thread1' and a wait time of 100 milliseconds.
  //The wait time is the time in between interations of the thread.  
  thread1 = new IOIOThread("thread1", 100);
  //Start our thread.
  thread1.start();
  
  while(ioio_good == false){
   
  }
}

//Main draw loop is repeated 60 times a second. 
void draw() {

  //Set background to black.
  background(0,0,0);

  //Draw the white keys.
  fill(255);
  stroke(155);
  rect(50, 10, 50, height); //c
  rect(100, 10, 50, height); //d
  rect(150, 10, 50, height); //e
  rect(200, 10, 50, height); //f
  rect(250, 10, 50, height); //g
  rect(300, 10, 50, height); //a
  rect(350, 10, 50, height); //b
  rect(400, 10, 50, height); //c

  //Draw the black keys.
  fill(0);
  rect(75, 10, 50, 300); //c#
  rect(125, 10, 50, 300); //d#
  rect(225, 10, 50, 300); //f#
  rect(275, 10, 50, 300); //g#
  rect(325, 10, 50, 300); //Bb
}

//This is a function to open the piezo pin at the correct frequency and play a tone, 
//the length of which is determined by the value we pass to the sleep() function.
void playTone(int freq) {

  try {
    thread1.piezo = ioio.openPwmOutput(thread1.piezoPin, freq);
    thread1.piezo.setDutyCycle(.5);
  } 
  catch (ConnectionLostException e) {
  }
  try {
    thread1.sleep(100); 
  } 
  catch (InterruptedException e) {
  }
  thread1.piezo.close();
}

//This is called when there is a touch event.
public boolean surfaceTouchEvent(MotionEvent event) {  

  //There was a touch event - what kind?
  int action = event.getAction();
  
  //Get the X position of where the touch was, so we know which note to play.
  int pos = (int)event.getX();

  //If the action was a touch on the screen, play a note based on the positon of the touch.
  if (action == MotionEvent.ACTION_DOWN) {

    if (pos < 100) {
      playTone(523);
    }  

    if (pos >= 100 && pos < 150) {
      playTone(587);
    }

    if (pos >= 150 && pos < 200) {
      playTone(659);
    }

    if (pos >= 200 && pos < 250) {
      playTone(698);
    }

    if (pos >= 250 && pos < 300) {
      playTone(784);
    }

    if (pos >= 300 && pos < 350) {
      playTone(880);
    }

    if (pos >= 350 && pos < 400) {
      playTone(988);
    }
    if (pos > 400) {
      playTone(1047);
    }
  }

  //If you want the variables for motionX/motionY, mouseX/mouseY etc.
  //to work properly, you'll need to call super.surfaceTouchEvent().
  return super.surfaceTouchEvent(event);
}

