import controlP5.*;
import java.util.*;
Table xy;

float xPos = 1;
float yPos = 1;

float xSpeed = 5;

float spacing = 0;

String currentTime = "18:55:00";

int peopleCount = 0;



ControlP5 cp5;
ScrollableList d1; 
Textlabel myTextlabelA;

void setup() {
  size(800, 800);
  xy = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-09-15T18%3A41%3A32&rToDate=2022-09-17T18%3A41%3A32&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+In", "csv");
  cp5 = new ControlP5(this);
  
  frameRate(80);

  List l = Arrays.asList("18:55:00", "b", "c", "d");
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
                    .setPosition(100,50)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",20))
                    .setValue(3);
                    
}



void dropdown(int n) {
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));


  CColor c = new CColor();
  c.setBackground(color(255, 0, 0));
  cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);

}

float getNumberOfPeople() {
  // For all of the columns in the first row, get the date and check if the date contains the currentTime selected and return it
  for (int i = 0; i< xy.getColumnCount(); i++) {
    String date = xy.getString(i, 0);
    if (date.contains(currentTime)) {
      peopleCount = xy.getInt(i, 1);
      return xy.getFloat(i, 1);
    }
  }  
  return 0;
}



void draw() {
  //popMatrix();

  background(225);
  pushMatrix();

  //translate(xPos,yPos); 
 
    for (int j = 0; j < y; j++) {
      drawCircle(j*200);
    }
  
    //for (int i = 0; i<6; i++) {
    //float y= 6;
    //peopleCount = 6;
    //for (int j = 0; j < y; j++) {
    //  drawCircle(j*200);
     
    //}
    
    
     
     
    
  
  xPos += xSpeed;
  
   // Change textLabel's label to current peopleCount
   popMatrix();
   //cp5.getController("people").setPosition(100,50);
   //cp5.getController("people").setValueLabel("People count " + peopleCount + "");
}


void drawCircle(float spacing) {
  //pushMatrix();
  circle(xPos-spacing, height-100, 100);
  //popMatrix();
}
