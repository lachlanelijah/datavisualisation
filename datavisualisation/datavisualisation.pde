import beads.*; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import controlP5.*;
import java.util.*;

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
int datatimer;

Boolean pause;
float sliderValue;
float parsedMinute;
PFont montserrat;

Table xy;
Table xz;
Table yz;

int fromRow;

float peopleComingIn=0;
int peopleCount = 0;
float sunVolt;
LinkedList<People> peoples = new LinkedList<People>();

String screen;
// Audio
AudioContext ac;

Glide gain;
Glide gainMorning;
Glide gainAfternoon;
Glide gainNight;

Envelope envRate1;
Envelope envRate2;
Envelope envRate3;
SamplePlayer sp1;
SamplePlayer sp2;
SamplePlayer sp3;

void setup() {

  // Data from 01/1/2021 to 01/01/2022
  xy = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-01-01T01%3A00%3A54&rToDate=2022-01-01T01%3A00%3A35.151&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+In", "csv");
  xz = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-01-01T01%3A00%3A54&rToDate=2022-01-01T01%3A00%3A35.151&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+Out", "csv");
  yz = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-01-01T00%3A00&rToDate=2022-01-01T00%3A00&rFamily=weather&rSensor=SV", "csv");

  montserrat = createFont("Montserrat-Medium.ttf", 75);

  rectMode(CORNERS);

  gui = new ControlP5(this);
  size(900, 700);
  noStroke();
  background(178, 224, 245);
  frameRate(60);
  timer = millis();
  datatimer = millis();
    gui.addTextlabel("people")
    .setText("People count: " + peopleCount + "")
    .setPosition(5, 600)
    .setColorValue(0xffffff00)
    .setFont(createFont("montserrat",40))
    .setValue(3)
  ;

  gui.addButton("back")
    .setPosition(10, 660)
    .setSize(46, 20)
    .setValue(0)
    .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
    .setLabel("←")
  ;
  
  gui.addButton("forward")
    .setPosition(844, 660)
    .setSize(46, 20)
    .setValue(0)
    .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
    .setLabel("→")
  ;
  
  gui.addButton("monthForward")
    .setLabel("Month →")
    .setValue(0)
    .setPosition(830, 170)
    .setSize(40, 30)
    .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
  ;
  
  gui.addButton("monthBack")
    .setLabel("← Month")
    .setValue(0)
    .setPosition(680, 170)
    .setSize(40, 30)
    .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
  ;
  
  gui.addButton("dayForward")
    .setLabel("Day →")
    .setValue(0)
    .setPosition(780, 170)
    .setSize(40, 30)
    .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
  ;
  
  gui.addButton("dayBack")
    .setLabel("← Day")
    .setValue(0)
    .setPosition(730, 170)
    .setSize(40, 30)
    .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
  ;
    
  gui.addButton("screen1")
   .setLabel("Screen 1")
   .setValue(0)
   .setPosition(0, 0)
   .setSize(100, 40)
   .setColorBackground(color(62,195,255))
   .setColorActive(color(0,0,0))
   .setColorForeground(color(7,151,255))
 ;
 
 gui.addButton("screen2")
   .setLabel("Screen 2")
   .setValue(0)
   .setPosition(100, 0)
   .setSize(100, 40)
   .setColorBackground(color(62,195,255))
    .setColorActive(color(0,0,0))
    .setColorForeground(color(7,151,255))
 ;
 
 gui.getController("screen1")
   .getCaptionLabel()
   .setFont(montserrat)
   .toUpperCase(false)
   .setSize(15)
 ;
 
 gui.getController("screen2")
   .getCaptionLabel()
   .setFont(montserrat)
   .toUpperCase(false)
   .setSize(15)
 ;
 
 gui.getController("back")
   .getCaptionLabel()
   .setFont(montserrat)
   .setSize(15)
 ;
 
 gui.getController("forward")
   .getCaptionLabel()
   .setFont(montserrat)
   .setSize(15)
 ;
 
 gui.getController("monthForward")
   .getCaptionLabel()
   .setFont(montserrat)
   .toUpperCase(false)
   .setSize(9)
  ;
  
  gui.getController("monthBack")
   .getCaptionLabel()
   .setFont(montserrat)
   .toUpperCase(false)
   .setSize(9)
  ;
  
  gui.getController("dayForward")
   .getCaptionLabel()
   .setFont(montserrat)
   .toUpperCase(false)
   .setSize(9)
  ;
  
  gui.getController("dayBack")
   .getCaptionLabel()
   .setFont(montserrat)
   .toUpperCase(false)
   .setSize(9)
  ;

  hour = 0;
  minute = 0;

  day = 1;
  month = 1;
  year = 2021;

  screen = "1";

  ac = new AudioContext();
  gain = new Glide(ac, 1);
  gainMorning= new Glide(ac, 1);
  gainAfternoon = new Glide(ac, 1);
  gainNight= new Glide(ac, 1);
  sound();
}

void sound() {
  // Put three different audios in 3 sample players
  File morning = dataFile("morning.wav");
  String file1 =   morning.getAbsolutePath();
  File afternoon = dataFile("afternoon.wav");
  String file2 =   afternoon.getAbsolutePath();
  File night = dataFile("night.wav");
  String file3 =   night.getAbsolutePath();

  sp1 = new SamplePlayer(ac, SampleManager.sample(file1));
  sp2 = new SamplePlayer(ac, SampleManager.sample(file2));
  sp3 = new SamplePlayer(ac, SampleManager.sample(file3));



  // Create envelopes and set rates to default 1
  envRate1 = new Envelope(ac, 1);
  sp1.setRate(envRate1);
  envRate2 = new Envelope(ac, 1);
  sp2.setRate(envRate2);
  envRate3 = new Envelope(ac, 1);
  sp3.setRate(envRate3);

  // Loop over the audios start from the beginning to end
  sp1.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  sp2.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  sp3.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);




  // Create panners
  Panner p1 = new Panner(ac, 0);
  Panner p2 = new Panner(ac, 0);
  Panner p3 = new Panner(ac, 0);




  // Greate gains
  Gain g1 = new Gain(ac, 2, gainMorning);
  Gain g2 = new Gain(ac, 2, gainAfternoon);
  Gain g3 = new Gain(ac, 2, gainNight);


  // Add sample players to the panners
  p1.addInput(sp1);
  p2.addInput(sp2);
  p3.addInput(sp3);




  // Add the panners to the gain
  g1.addInput(p1);
  g2.addInput(p2);
  g3.addInput(p3);


  // Create a master gain and add all the gains
  Gain masterGain = new Gain(ac, 2, gain);

  masterGain.addInput(g1);
  masterGain.addInput(g2);
  masterGain.addInput(g3);



  // Add the mastergain to the output
  ac.out.addInput(masterGain);
  ac.start();
}

void draw() {
  if (hour >= 6 && hour <= 10) {
    gainMorning.setValue(1);
    gainAfternoon.setValue(0);
    gainNight.setValue(0);
  } else if (hour >= 11 && hour <= 18) {
    gainMorning.setValue(0);
    gainAfternoon.setValue(1);
    gainNight.setValue(0);
  } else {
    gainMorning.setValue(0);
    gainAfternoon.setValue(0);
    gainNight.setValue(1);
  }
  background(178, 224, 245);

  if (screen == "1") {
     gui.getController("people").setValueLabel("People coming in: " + peopleCount + "");
    drawScreen1Scenery();
  } else {
     gui.getController("people").setValueLabel("People going out: " + peopleCount + "");
    drawScreen2Scenery();
  }

  fill(62, 195, 255); //timeline light blue
  rect(66, 660, 834, 680);
  drawScaleNumbers();

  fill(0);
  textAlign(CENTER);
  textFont(montserrat);

  time = paddedHour + ":" + paddedMinute;
  text(time, 770, 100);

  textSize(40);

  date = paddedDay + "-" + paddedMonth + "-" + year;
  text(date, 770, 150);

  if (millis()-datatimer < 5000) {
    //if (millis()-datatimer > 1000) {
    drawPeople(false);
    //}
    //drawPeople(false);
    //datatimer = millis();
    //println("keep it running...");
  }
  if (millis()-datatimer > 5000) {
    drawPeople(true);
    datatimer = millis();
    println("checking count...");
  }

  updateTimeline();
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
  formatDate();
}


void drawPeople(Boolean fiveSec) { //<>//
  
  Boolean gotPeople = false;
  for (int i = 0; i < xy.getRowCount(); i++) {
    String dateAPI = year + "-" + paddedMonth + "-" + paddedDay;
    switch (screen) {
    case "1":
      if (xy.getString(i, 0).contains(dateAPI + " " + time + ":0")) {
        println("got people.");
        peopleComingIn=xy.getInt(i, 1);
        gotPeople = true;
      }
      break;
    case "2":
      if (xz.getString(i, 0).contains(dateAPI + " " + time + ":0")) {
        println("got people.");
        peopleComingIn=xz.getInt(i, 1);
        gotPeople = true;
      }
      break;
    }
  }

  if (!fiveSec) { //<>//
    if (gotPeople) { //<>// //<>// //<>//
           if (peoples.size() > peopleComingIn){
        peoples.clear();
         for (int j = 0; j < peopleComingIn; j++) {
          peoples.add(new People(j*200));
          
        }
        
        
      }
      
      else if (peoples.size() != peopleComingIn) {   //<>//
        for (int j = 0; j < peopleComingIn; j++) { //<>//
          peoples.add(new People(j*200)); //<>//
          
        }
      }
     
      gotPeople = false; //<>//
    }

    for (People people : peoples) { //<>//
      switch (screen) {
      case "1":
        people.drawCircle(1); //<>//
        people.decreaseSpeed1(peopleComingIn); //<>//
        break;
      case "2":
        people.drawCircle(2); //<>//
        people.decreaseSpeed2(peopleComingIn); //<>//
        break;
      }
    }
  } else if (fiveSec) {
    if (gotPeople) {
      peoples.clear();
      gotPeople = false;
    } else {
      peoples.clear();
    }
  }
  peopleCount = peoples.size();
}

void formatTime() {
  int minuteCheck = Integer.parseInt(paddedMinute);
  int hourCheck = Integer.parseInt(paddedHour);
  //System.out.println("min: " + minute);
  //System.out.println("hour: " + hour);
  //System.out.println("minuteCheck: " + minuteCheck);
  //System.out.println("hourCheck: " + hourCheck);

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
  datatimer = millis() + 600;
  drawPeople(true);
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
  datatimer = millis() + 600;
  drawPeople(true);
}



void monthForward() {
    if (month >= 1 && month < 12) {
      month += 1;
      day = 1;
    } else if (month == 12) {
      month = 1;
      day = 1;
    }
    datatimer = millis() + 600;
}

void monthBack() {
  if (month > 1 && month <= 12) {
      month -= 1;
      day = 1;
  } else if (month == 1) {
      month = 12;
      day = 1;
  }
    datatimer = millis() + 600;
  
  datatimer = millis() + 600;
}
//january, march, may, july, aug, oct, dec 31
//feb 28
// april, june, september, november 30
void dayForward() {

  //Boolean monthCheck = false;

  if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10) {
    if (day < 31) {
      day+= 1;
    } else {
      day = 1;
      month += 1;
      //monthCheck = true;
    }
  } else if (month == 2) {
    if (day < 28) {
      day += 1;
    } else {
      day = 1;
      month += 1;
      //monthCheck = true;
    }
  } else if (month == 4 || month == 6 || month == 9 || month == 11) {
    if (day < 30) {
      day += 1;
    } else {
      day = 1;
      month += 1;
      //monthCheck = true;
    }
  } else if (month == 12) {
    day = 1;
    month = 1;
  }

  //if (monthCheck == true && month > 12) {
  //  month = 1;
  //}
  datatimer = millis() + 600;
}

void dayBack() {
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
  } else if (day == 1) {
  } else {
    day -= 1;
  }
  datatimer = millis() + 600;
}

void updateTimeline() {
  float pixel;
  pixel = minute * 0.5333333333;
  pixel += hour * 60*0.5333333333;
  //System.out.println("timeline location: " + pixel);

  fill(7, 151, 216);
  rect(66, 660, 66+pixel, 680);
}

void drawScreen1Scenery() {
  fill (59, 59, 59); //ground
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

  fill(144, 144, 144); //back facade
  quad(440, 0, 400, 480, 300, 475, 300, 0);

  fill(193, 193, 193); //facade
  quad(0, 0, 0, 400, 350, 300, 400, 0);

  fill(226, 227, 206); //building 10 front
  quad(485, 0, 485, 470, 640, 452, 640, 0);
  
  Sun sun = new Sun();
  Boolean sunnyD = false;
  for (int i = 0; i < yz.getRowCount(); i++) {
    String dateAPI = year + "-" + paddedMonth + "-" + paddedDay;
    if (yz.getString(i, 0).contains(dateAPI + " " + time)) {
      sunVolt=yz.getFloat(i, 1);
      sunnyD = true;
      //println(sunVolt);
    }
  }
  if (sunnyD) {
    sun.drawSun(sunVolt, 1);
    sunnyD = false;
  } else if (!sunnyD) {
    sun.drawSun(sunVolt, 1);
  }
  
  fill(255);
  rect(660, 30, 880, 160);
}

void drawScreen2Scenery() {
  Sun sun = new Sun();
  Boolean sunnyD = false;
  for (int i = 0; i < yz.getRowCount(); i++) {
    String dateAPI = year + "-" + paddedMonth + "-" + paddedDay;
    if (yz.getString(i, 0).contains(dateAPI + " " + time)) {
      sunVolt=yz.getFloat(i, 1);
      sunnyD = true;
      //println(sunVolt);
    }
  }
  
  if (sunnyD) {
    sun.drawSun(sunVolt, 2);
    sunnyD = false;
  } else if (!sunnyD) {
    sun.drawSun(sunVolt, 2);
  }

  fill(222, 222, 222); //top lighter grey concrete
  quad(300, 0, 400, 0, 560, 100, 560, 300);

  fill(200, 200, 200);//top darker grey concrete
  quad(0, 0, 300, 0, 600, 165, 0, height);

  fill(80, 45, 45); //maroon bar top
  quad(560, 100, width, 85, width, 130, 560, 144);

  fill(57, 32, 32); //maroon bar bottom
  quad(560, 144, width, 130, width, 145, 590, 160);

  fill(173, 173, 173); //floor
  quad(0, 350, width, 350, width, height, 0, height);

  fill (75, 63, 63); //mat in front of door
  quad(375, 480, width, 490, width, 540, 200, 530);

  fill(155, 86, 52); //brown left side wall
  quad(0, 0, 375, 150, 375, 500, 0, 600);

  fill(134, 222, 255); //glass
  quad(375, 165, width, 145, width, 490, 375, 480);

  fill(130, 130, 130); //pillar left 
  quad(415, 150, 455, 143, 455, 505, 415, 500);

  fill(143, 143, 143); //pillar right
  quad(455, 143, 485, 150, 485, 500, 455, 505);
  rectMode(CORNERS);
  fill(255);
  rect(660, 30, 880, 160);
}

void drawScaleNumbers() {
  textSize(15);
  if (screen == "1") {
    fill(255, 255, 255);
  } else {
    fill(0);
  }
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

void screen1() {
  screen = "1";
  drawPeople(true);
  datatimer = millis();
}

void screen2() {
  screen = "2";
  drawPeople(true);
  datatimer = millis();
}
