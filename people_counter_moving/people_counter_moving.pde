import controlP5.*; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.*;
Table xy;

float xPos = 1;
float yPos = 1;

float xSpeed = 5;

float spacing = 0;



int peopleCount = 0;



ControlP5 cp5;
ScrollableList d1; 
Textlabel myTextlabelA;

void setup() {
  size(800, 800);
  xy = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-10-05T12%3A19%3A24&rToDate=2022-10-07T12%3A19%3A24&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+In", "csv");
  cp5 = new ControlP5(this);
  frameRate(80);

  List l = Arrays.asList("6:00-7:00am", "12:00-1:00pm", "8:00-9:00pm");    
  d1 =cp5.addScrollableList("dropdown")
    .setPosition(100, 100)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  myTextlabelA =  cp5.addTextlabel("people")
    .setText("People count " + peopleCount + "")
    .setPosition(100, 50)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 20))
    .setValue(3);
}



void dropdown(int n) {
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));


  CColor c = new CColor();
  c.setBackground(color(255, 255, 0));
  cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
}

float getNumberOfPeople() {
  // For all of the columns in the first row, get the date and check if the date contains the currentTime selected and return it
  String currentTime = "13:00:00";
  String date;
  for (int i = 0; i< xy.getRowCount(); i++) {
    date = xy.getString(i, 0);
    if (date.contains(currentTime)) {
      peopleCount = xy.getInt(i, 1);
      return xy.getFloat(i, 1);
    }
  }  
  return 0;
}

float getNumberOfPeopleInAHour(String currentSelectedTime) {
  int sum = 0;

  //if(currentSelectedTime.equals("6:00-7:00am")){
  //   String date;
  //  String startTime = "6:";
  //  String endTime = "7:";


  //  int startRow = 0;
  //  int lastRow = 0;

  //   for (int i = 0; i< xy.getRowCount(); i++) {
  //date = xy.getString(i, 0);
  //if (date.substring(0,1).equals(currentDay) && date.contains(startTime) && (!date.contains("16:00:00")) ){
  //  startRow = i;
  //  break;
  // }
  // else if(!date.substring(0,1).equals("currentDay")){
  //   break;

  // }
  //}

  //     for (int i = 0; i< xy.getRowCount(); i++) {
  //date = xy.getString(i, 0);
  // if (date.substring(0,1).equals(currentDay) && date.contains(endTime) && (!date.contains("17:00:00")) ){
  //  startRow = i;
  //  break;
  // }
  // else if(!date.substring(0,1).equals("currentDay")){
  //   break;
  //}
  //}

  //for(int i = startRow; i <= lastRow; i++){ 
  //    sum += xy.getInt(i, 1);
  //}

  //}
  String currentDay = "2022-10-05";

  if (currentSelectedTime.equals("12:00-1:00pm")) {
    String date;
    String startTime = "12:";
    String endTime = "13:00:00";


    int startRow = 0;
    int lastRow = 0;

    for (int i = 0; i< xy.getRowCount(); i++) {
      date = xy.getString(i, 0);
      if (date.substring(0, 10).equals(currentDay) && date.contains(startTime)) {
        startRow = i;
        break;
      } else if (!date.substring(0, 10).equals(currentDay)) {
        break;
      }
    }

    for (int i = 0; i< xy.getRowCount(); i++) {
      date = xy.getString(i, 0);
      if (date.substring(0, 10).equals(currentDay) && date.contains(endTime)) {
        lastRow = i;
        break;
      } else if (!date.substring(0, 10).equals(currentDay)) {
        break;
      }
    }

    for (int i = startRow; i <= lastRow; i++) { 
      sum += xy.getInt(i, 1);
    }
  }




  peopleCount = sum;
  return sum;
}



void draw() {
  background(225);
  pushMatrix();

  float y = getNumberOfPeopleInAHour("12:00-1:00pm");
  //float y = getNumberOfPeople();
  for (int j = 0; j < y; j++) {
    drawCircle(j*200);
  }








  xPos += xSpeed;
  popMatrix();
  // Change textLabel's label to current peopleCount
  cp5.getController("people").setPosition(100, 50);
  cp5.getController("people").setValueLabel("People count " + peopleCount + "");
}


void drawCircle(float spacing) {
  //pushMatrix();
  circle(xPos-spacing, height-100, 100);
  //popMatrix();
}
