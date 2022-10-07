import beads.*;
import controlP5.*;

ControlP5 gui;

String time;

int hour;
String paddedHour = "00";

int minute;
String paddedMinute = "00";

String date;

int day;
String paddedDay = "01";

int month;
String paddedMonth = "01";

int year;

int timer;

Boolean pause;
float sliderValue;
float parsedMinute;
PFont montserrat;

void setup() {
  
  PImage[] forwardImg = {loadImage("data/forward.png"), loadImage("data/forward_hover.png"), loadImage("")};
  PImage[] backImg = {loadImage("data/back.png"), loadImage("data/back_hover.png"), loadImage("")};
  
  montserrat = createFont("Montserrat-Medium.ttf", 75);
  
  rectMode(CORNERS);
  
  gui = new ControlP5(this);
  size(900, 700);
  noStroke();
  background(178, 224, 245);
  frameRate(60);
  timer = millis();
 
 gui.addButton("back")
   .setPosition(10, 660)
   .setSize(46,20)
   .setValue(0)
   .setImages(backImg)
 ;
 gui.addButton("forward")
   .setPosition(844, 660)
   .setSize(46,20)
   .setValue(0)
   .setImages(forwardImg)
 ;
 gui.addButton("monthForward")
   .setLabel("month ->")
   .setValue(0)
   .setPosition(830, 170)
   .setSize(40, 30)
 ;
 gui.addButton("monthBack")
   .setLabel("<- month")
   .setValue(0)
   .setPosition(680, 170)
   .setSize(40, 30)
 ;
 gui.addButton("dayForward")
   .setLabel("day ->")
   .setValue(0)
   .setPosition(780, 170)
   .setSize(40, 30)
 ;
 gui.addButton("dayBack")
   .setLabel("<- day")
   .setValue(0)
   .setPosition(730, 170)
   .setSize(40, 30)
   
 ;
 
 hour = 0;
 minute = 0;
 
 day = 1;
 month = 1;
 year = 2021;
  
}

void draw() {
  background(178, 224, 245);
  
  drawScenery();
  drawScaleNumbers();

  fill(0);
  textAlign(CENTER);
  textFont(montserrat);

  time = paddedHour + ":" + paddedMinute;
  text(time, 770, 100);
  
  textSize(40);
  
  date = paddedDay + "/" + paddedMonth + "/" + year;
  text(date, 770, 150);
 
  if (millis()-timer > 1000) {
    updateTimeline();
    //every 1 second, format the time and the date, update the timeline, reset the timer
    if (hour == 23 && minute == 59) {
      //reset to 00:00
      hour = 0;
      minute = 0;
      paddedMinute = "00";
      paddedHour = "00";
      dayForward();
    } else if (minute < 59) {
      minute += 1;
    } else if (minute == 59) {
      //minute rollover
      minute = 0;
      paddedMinute = "00";
      hour += 1;
    }
    
    formatTime();
    formatDate();
    
    timer = millis();
  }
  
}

void formatTime() {
  int minuteCheck = Integer.parseInt(paddedMinute);
  int hourCheck = Integer.parseInt(paddedHour);
  System.out.println("min: " + minute);
  System.out.println("hour: " + hour);
  System.out.println("minuteCheck: " + minuteCheck);
  System.out.println("hourCheck: " + hourCheck);
  
  if (minuteCheck <= 9 && hourCheck <= 9) {
    paddedMinute = String.format("%02d", minute);
    paddedHour = String.format("%02d", hour);
    time = paddedHour + ":" + paddedHour;
  } else if (minuteCheck <= 9 && hourCheck > 9) {
    paddedMinute = String.format("%02d", minute);
    paddedHour = Integer.toString(hour);
    time = paddedHour + ":" + paddedMinute;
  } else if (minuteCheck > 9 && hourCheck <= 9) {
    paddedMinute = Integer.toString(minute);
    paddedHour = String.format("%02d", hour);
    time = paddedHour + ":" + minute;
  } else {
    //if (minute == 0) {
    //  paddedMinute = "00";
    //}
    //if (hour == 0) {
    //  paddedHour = "00";
    //}
    
    paddedMinute = Integer.toString(minute);
    paddedHour = Integer.toString(hour);
  }
}

void formatDate() {
  int dayCheck = Integer.parseInt(paddedDay);
  int monthCheck = Integer.parseInt(paddedMonth);
  //System.out.println("dayCheck: " + dayCheck);
  //System.out.println("monthCheck: " + monthCheck);
  //System.out.println("day:" + day);
  //System.out.println("month: " + month);
  
 if (dayCheck <= 9 && monthCheck <= 9) {
    paddedDay = String.format("%02d", day);
    paddedMonth = String.format("%02d", month);
    date = paddedDay + "/" + paddedMonth + "/" + year;
  } else if (dayCheck <= 9 && monthCheck > 9) {
    paddedDay = String.format("%02d", day);
    paddedMonth = Integer.toString(month);
    date = paddedDay + "/" + paddedMonth + "/" + year;
  } else if (dayCheck > 9 && monthCheck <= 9) {
    paddedMonth = String.format("%02d", month);
    paddedDay = Integer.toString(day);
    date = paddedDay + "/" + paddedMonth + "/" + year;
  }
  
  //System.out.println("padDay: " + paddedDay);
  //System.out.println("padMonth: " + paddedMonth);
}


void forward() {
  if (hour >= 0 && hour < 24) {
    hour += 1;
    minute = -1;
  }
  
  if (hour == 24) {
   hour = 0;
   minute = -1;
  }
}

void back() {
 if (hour == 0) {
   hour = 24;
   minute = -1;
 }
 if (hour > 0) {
   hour -= 1;
   minute = -1;
 }
}

void monthForward(){
  if (month >= 1 && month < 12) {
    month += 1;
    day = 1;
  }
  
  if (month == 12) {
    month = 1;
    day = 1;
  }
}

void monthBack(){
  if (month >= 1 && month < 12) {
    month -= 1;
    day = 1;
  }
  
  if (month == 1) {
    month = 12;
    day = 1;
  }
}
//january, march, may, july, aug, oct, dec 31
//feb 28
// april, june, september, november 30
void dayForward(){
  
  Boolean monthCheck = false;
  
  if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
    if (day < 31) {
      day+= 1;
    } else {
      day = 1;
      month += 1;
      monthCheck = true;
    }
  } else if (month == 2) {
    if (day < 28) {
      day += 1;
    } else {
      day = 1;
      month += 1;
      monthCheck = true;
    }
  } else if (month == 4 || month == 6 || month == 9 || month == 11) {
    if (day < 30) {
      day += 1;
    } else {
      day = 1;
      month += 1;
      monthCheck = true;
    }
  }
  
  if (monthCheck == true && month > 12) {
    month = 1;
  }
}

void dayBack(){
  if (month == 1 && day == 1) {
    month = 12;
    day = 31;
  } else if (month == 2 && day == 1) {
    month = 1;
    day = 31;
  } else if (month == 3 && day == 1) {
    month = 2;
    day = 28;
  } else if (month == 4 && day == 1) {
    month = 3;
    day = 31;
  } else if (month == 5 && day == 1) {
    month = 4;
    day = 30;
  } else if (month == 6 && day == 1) {
    month = 5;
    day = 31;
  } else if (month == 7 && day == 1) {
    month = 6;
    day = 30;
  } else if (month == 8 && day == 1) {
    month = 7;
    day = 31;
  } else if (month == 9 && day == 1) {
    month = 8;
    day = 31;
  } else if (month == 10 && day == 1) {
    month = 9;
    day = 30;
  } else if (month == 11 && day == 1) {
    month = 10;
    day = 31;
  } else if (month == 12 && day == 1) {
    month = 11;
    day = 30;
  } else {
    day -= 1;
  }
}

void updateTimeline() {
  float pixel;
  pixel = minute * 0.5333333333;
  pixel += hour * 60*0.5333333333;
  System.out.println("timeline location: " + pixel);
  
  fill(7, 151, 216);
  rect(66, 660, 66+pixel, 680); 
}

void drawScenery() {
  fill (59,59,59); //ground
  quad(0, 440, width, 440, width, height, 0, height);
  
  fill(7, 151, 216); // left glass (darker)
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
  
  fill(62, 195, 255); //timeline light blue
  rect(66, 660, 834, 680); 
}

void drawScaleNumbers() {
  textSize(15);
  fill(255,255,255);
  text(0, 66, 695);
  text(3, 162, 695);
  text(6, 258, 695);
  text(9, 354, 695);
  text(12, 450, 695);
  text(15, 546, 695);
  text(18, 642, 695);
  text(21, 738, 695);
  text(24, 834, 695);
}
