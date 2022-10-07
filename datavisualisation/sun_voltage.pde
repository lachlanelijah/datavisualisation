float posX = 1;
float posY = 1;
Table sun;
String[] lines;
String[] listb;
String[] listc;
int test;
int voltage;
int goldenRed = 225;
int goldenGreen = 120;
int goldenBlue = 40;
int dayRed = 185;
int dayGreen = 220;
int dayBlue = 250;
int cloudyRed = 95;
int cloudyGreen = 115;
int cloudyBlue = 150;
int nightRed = 1;
int nightGreen = 25;
int nightBlue = 60;
int counter = 0;
int diff = 0;
// int[] hours =       {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24};
// float[] sun.getInt =  {0, 0, 1, 2, 4, 5, 6, 8, 8, 9, 10, 10, 10,  7,  4,  4,  6,  5,  4,  2,  1,  0,  0,  0};
// simulating a bright morning and rainy/overcast afternoon

void setup(){
  size(800,800);
  frameRate(24);
  background(0);
  sun = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-08-17T00%3A00&rToDate=2022-08-18T00%3A00&rFamily=weather&rSensor=SV", "csv");
  lines = loadStrings("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-10-03T23%3A20%3A37&rToDate=2022-10-05T23%3A20%3A37&rFamily=people_sh&rSensor=CB11.PC02.16.JonesStEast&rSubSensor=CB11.02.JonesSt+In");  
}
//1000 / 20fps -> 50ms
//1000 / 60fps -> 16.667 ms

void draw(){
  //fill(0);
  //for (counter = 0; counter < 24; counter += 1) {
  //noLoop();

  for (int i=0; i<lines.length; i++) {
    //a way to split the strings into separate characters.
    String x = lines[i];
    String[] list = split(x, ' ');
    //println(list[1]);
    String a = list[1];
    listb = split(a, ',');
    //println(listb[0]);
    //println(listb[1]);
    String c = listb[0];
    listc = split(c, ':');
    println("hour:", listc[0], "voltage:", listb[1]);
    }
    
    counter += 1;
    // println("counter is: " + counter);
    diff = 12 - counter;
    if (diff < 0) {
        diff = diff * -1;
    }
    
    // IF THE VOLTAGE IS AT THIS LOW RANGE, SET THE BACKGROUND COLOR TO DARK BLUE
    if (sun.getInt(counter, 1) >= 0 && sun.getInt(counter, 1) < 8) {
        println("Voltage1: " + sun.getInt(counter, 1));
        background(nightRed*diff/(sun.getRowCount()*0.67), nightGreen*diff/(sun.getRowCount()*0.67), nightBlue*diff/(sun.getRowCount()*0.67));
        test = 1;
        
    
    // IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 5 AM AND 6 AM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    } else if (sun.getInt(counter, 1) >= 8 && sun.getInt(counter, 1) < 14 && counter >= 5 && counter <= 6) {
        println("sun.getInt: " + sun.getInt(counter, 1));
        diff = diff * -1;
        background( (nightRed+goldenRed)/2 *diff/(sun.getRowCount()*0.67), (nightGreen+goldenGreen)/2 *diff/(sun.getRowCount()*0.67), (nightBlue+goldenBlue)/2 *diff/(sun.getRowCount()*0.67));
        diff = diff * -1;
        test = 2;
        
    //} else if (sun.getInt(counter, 1) >= 8 && sun.getInt(counter, 1) < 14 && sun.getInt(counter, 0) >= 05:00:00 && counter <= 06:00:00) {
    //    println("sun.getInt: " + sun.getInt(counter, 1));
    //    diff = diff * -1;
    //    background( (nightRed+goldenRed)/2 *diff/(sun.getRowCount()*0.67), (nightGreen+goldenGreen)/2 *diff/(sun.getRowCount()*0.67), (nightBlue+goldenBlue)/2 *diff/(sun.getRowCount()*0.67));
    //    diff = diff * -1;
    //    test = 2;

// IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 5 PM AND 6 PM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    } else if (sun.getInt(counter, 1) >= 8 && sun.getInt(counter, 1) < 14 && counter >= 17 && counter <= 18) {
        println("sun.getInt: " + sun.getInt(counter, 1));
        background( (nightRed+goldenRed)/2 *diff/(sun.getRowCount()*0.67), (nightGreen+goldenGreen)/2 *diff/(sun.getRowCount()*0.67), (nightBlue+goldenBlue)/2 *diff/(sun.getRowCount()*0.67));
        test = 2;

    //} else if (sun.getInt(counter, 1) >= 8 && sun.getInt(counter, 1) < 14 && sun.getInt(counter, 0) >= 17:00:00 && sun.getInt(counter, 0) <= 18:00:00) {
    //    println("sun.getInt: " + sun.getInt(counter, 1));
    //    background( (nightRed+goldenRed)/2 *diff/(sun.getRowCount()*0.67), (nightGreen+goldenGreen)/2 *diff/(sun.getRowCount()*0.67), (nightBlue+goldenBlue)/2 *diff/(sun.getRowCount()*0.67));
    //    test = 2;
    
// IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* IT IS NOT SUNRISE NOR SUNSET, SET THE BACKGROUND COLOR TO A CLOUDY BLUISH GRAY    
    } else if (sun.getInt(counter, 1) >= 8 || sun.getInt(counter, 1) < 14) {
        println("Voltage3: " + sun.getInt(counter, 1));
        background(cloudyRed*diff/(sun.getRowCount()*0.67), cloudyGreen*diff/(sun.getRowCount()*0.67), cloudyBlue*diff/(sun.getRowCount()*0.67));
        test = 3;
        
// IF THE VOLTAGE IS AT THIS HIGH RANGE, SET THE BACKGROUND COLOR TO BRIGHT BLUE    
    } else if (sun.getInt(counter, 1) >= 8 && sun.getInt(counter, 1) <= 27) {
        println("Voltage4: " + sun.getInt(counter, 1));
        background(dayRed*diff/(sun.getRowCount()*0.67), dayGreen*diff/(sun.getRowCount()*0.67), dayBlue*diff/(sun.getRowCount()*0.67));
        test = 4;
        
    } 
  //}  
  // if (counter >= 23) {
       // counter = 0;
  // }
}
  
  //if (counter < sun.getRowCount()) {
  //  voltage = sun.getInt(counter, 1);
  //  if (voltage < 6 && voltage < ) {
  //  voltage *= -1;
  //  }
  //  voltage++;
  //  if (voltage > 150) {
  //    voltage = 0;
  //    background(0);
  //    fill(255);
  //  }
    
    // PSEUDOCODE
    // If the counter value is still lower than the total number of rows, continue
      // If the voltage is between these values, it must be sunrise or sunset
        // Then, 
  
  
  //fill(250,0,255-circleSize*7);
  //circle(posX, posY,circleSize*5);
  //posX += speedX*2;
  //posY += speedY*2;
  //println(posX);
  //if (posX > width-circleSize/2 || posX < 0-circleSize/2){ // greater than width less than 0
  //  speedX *= -1;
  //}
  //println(posY);
  //if (posY > height-circleSize/2 || posY < 0-circleSize/2){
  //  speedY *= -1;
  //}
  //fill(255);
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
