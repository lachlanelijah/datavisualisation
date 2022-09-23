import beads.*;
import controlP5.*;

float posX = 1;
float posY = 1;
Table sun;
int voltage;
int dimRed;
int dimGreen;
int dimBlue;
int dayRed;
int dayGreen;
int dayBlue;
int nightRed;
int nightGreen;
int nightBlue;
int counter;

void setup(){
  size(800,500);
  frameRate(60);
  sun = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-08-17T14%3A08%3A54&rToDate=2022-08-19T14%3A08%3A54&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+In", "csv");
}

//1000 / 20fps -> 50ms
//1000 / 60fps -> 16.667 ms

void draw(){
  fill(0);
  if (counter < sun.getRowCount()) {
    voltage = sun.getInt(counter, 1);
    if (voltage < 6 && voltage < ) {
    voltage *= -1;
    }
    voltage++;
    if (voltage > 150) {
      voltage = 0;
      background(0);
      fill(255);
    }
    
    // PSEUDOCODE
    // If the counter value is still lower than the total number of rows, continue
      // If the voltage is between these values, it must be sunrise or sunset
        // Then, 
  }
  
  fill(250,0,255-circleSize*7);
  circle(posX, posY,circleSize*5);
  posX += speedX*2;
  posY += speedY*2;
  println(posX);
  if (posX > width-circleSize/2 || posX < 0-circleSize/2){ // greater than width less than 0
    speedX *= -1;
  }
  println(posY);
  if (posY > height-circleSize/2 || posY < 0-circleSize/2){
    speedY *= -1;
  }
  fill(255);
  // text(int(circleSize), posX, posY); display number of people counted at that data point
  
  
   
  // text("Move pointer to change shape color", 25, 25);
  //fill(mouseX,mouseY,75);
  //// circle(posX, posY, circleSize*10);
  //posX += speedX;
  //posY += speedY;
  //println(posX);
  //if (posX > width || posX < 0){ // greater than width less than 0
  //  speedX *= -1;
  //}
  //println(posY);
  //if (posY > height || posY < 0){
  //  speedY *= -1;
  // }
}

void mousePressed(){
  speedX *= -1;
  speedY *= -1;
}
