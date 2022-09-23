import beads.*;
import controlP5.*;

ControlP5 gui;

int hour = 0;
int minute = 0;
String time;
int timer;
String paddedHour = "00";
String paddedMinute = "00";
Boolean isPaused = false;

void setup() {
  
  gui = new ControlP5(this);
  size(900, 700);
  noStroke();
  background(178, 224, 245);
  frameRate(60);
  timer = millis();
  
  gui.addSlider("time_of_day")
    .setPosition(30,680)
    .setRange(0,24)
    .setValue(0)
    .setSize(800,10)
    .showTickMarks(true)
    .setNumberOfTickMarks(25)
  ;
  
 // gui.addButton("playpause")
 //   .setPosition(30, 650)
 //   .setSize(20, 20)
 //   .setValue(1)
 //;
 
 paddedHour = "00";
  
}

void draw() {
  background(178, 224, 245);
  
  fill (59,59,59); //ground
  quad(0, 440, width, 440, width, height, 0, height);
  
  fill(7, 151, 216); // left glass
  quad(0, 400, 0, 515, 100, 510, 100, 200);
  
  fill(201, 201, 181); //building 10 back
  quad(485, 0, 485, 470, 300, 460, 0, 0);
  
  fill(34, 139, 71);  //hedge left
  quad(450, 475, 300, 465, 300, 230, 450, 220);
  
  fill(40, 173, 87);//hedge right
  quad(450, 220, 475, 222, 475, 473, 450, 475);
  
  fill(62, 195, 255); //right glass
  quad(100, 510, 300, 475, 400, 0, 100, 200);
  
  fill(144,144,144); //back facade
  quad(440, 0, 400, 480, 300, 475, 300, 0);
  
  fill(193, 193, 193); //facade
  quad(0, 0, 0, 400, 350, 300, 400, 0);
  
  fill(226, 227, 206); //building 10 front
  beginShape();
  quad(485, 0, 485, 470, 640, 452, 640, 0);

  fill(0);
  textAlign(CENTER);

  time = paddedHour + ":" + paddedMinute;
  text(time, 770, 100);
  
  if (millis()-timer > 1000) {
    formatTime();
    
    if (hour == 23 && minute == 59) {
      plusOneSecond();
      hour = 0;
      minute = -1;
    }
    
    if (minute < 59) {
      plusOneSecond();
      paddedMinute = String.format("%02d", minute);
      paddedHour = String.format("%02d", hour);
    } else if (minute == 59) {
      minute = -1;
      hour += 1;
    }
  }
}

void plusOneSecond() {
  minute += 1;
  timer = millis();
}

void formatTime() {
  int minuteCheck = Integer.parseInt(paddedMinute);
  int hourCheck = Integer.parseInt(paddedHour);
  System.out.println("min:" + minuteCheck);
  System.out.println("hour: " + hourCheck);
 if (minuteCheck <= 9 && hourCheck <= 9) {
   paddedMinute = String.format("%02d", minute);
   paddedHour = String.format("%02d", hour);
   time = paddedHour + ":" + paddedHour;
 } else if (minuteCheck <= 9 && hourCheck > 9) {
   paddedMinute = String.format("%02d", minute);
   time = paddedHour + ":" + paddedMinute;
 } else if (minuteCheck > 9 && hourCheck <= 9) {
   paddedHour = String.format("%02d", hour);
   time = paddedHour + ":" + minute;
 }
}

//void playpause() {
//  while (isPaused == false) {
    
//  }
//}

void time_of_day(float val) {
  paddedMinute = "00";
  int temp = Math.round(val);
  paddedHour = String.valueOf(temp);
  hour = temp;
  minute = 0;
}
