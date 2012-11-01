/* 
  SparkFun SIKIO - Quickstart
  CC BY-SA, http://creativecommons.org/licenses/by-sa/3.0/
   
  PURPOSE:
  This is our thread class, it's a subclass of the standard thread class that comes with Processing
  we're not really doing anything dramatic, just using the start and run methods to control our interactions with the IOIO board.
  Basically, this is where you write code to control the IOIO. You can define global variables in the main sketch and use them
  here.
  
 */

//Used to display basic info
PFont font;

class IOIOThread extends Thread {

  boolean running;  //is our thread running?
  String id; //in case we want to name our thread
  int wait; //how often our thread should run
  DigitalOutput led;  //DigitalOutput type for the onboard led
  int count; //if we wanted our thread to timeout, we could put a counter on it, I don't use it in this sketch

  //our constructor
  IOIOThread(String s, int w) {
    id = s;
    wait = w;
    running = false;
    count = 0;
  }

  //override the start method
  void start() {
    running = true;
    //try connecting to the IOIO board, handle the case where we cannot or the connection is lost
    try {
      IOIOConnect();  //this function is down below and not part of the IOIO library
    } 
    catch (ConnectionLostException e) {
    }

    //try setting our led pin to the onboard led, which has a constant 'LED_PIN' associated with it
    try {
      led = ioio.openDigitalOutput(IOIO.LED_PIN);
    } 
    catch (ConnectionLostException e) {
    }

    //don't forget this
    super.start();
  }

  //start automatically calls run for you
  void run() {

    //while our sketch is running, keep track of the lightOn boolean, and turn on or off the led accordingly
    while (running) {
      //count++; 
      // Display the name of the example
      font = createFont("Monospaced",20);
      textFont(font);
      text("QuickStart",5,25);
       
      try {
        //LED ON
        led.write(false);
        lightOn = true;
        //Delay
        try {
          sleep(500);
        } 
        catch (Exception e) {
        }
        
        //LED OFF
        led.write(true);
        lightOn = false;
        //Delay
        try {
          sleep(500);
        } 
        catch (Exception e) {
        }
      } 
      catch (ConnectionLostException e) {
      }
    }
  }

  //often we may want to quit or stop or thread, so I include this here but I'm not using it in this sketch 
  void quit() {
    running = false;
    ioio.disconnect();
    interrupt();
  }


  //a simple little method to try connecting to the IOIO board
  void IOIOConnect() throws ConnectionLostException {

    try {
      ioio.waitForConnect();
    }
    catch (IncompatibilityException e) {
    }
  }
}

