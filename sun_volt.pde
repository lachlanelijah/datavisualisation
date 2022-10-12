float posX = 1;
float posY = 1;
Table sun;
String[] lines;
String[] listb;
String[] listc;
int hour;
int value;
int test;
int voltage;
int goldenRed = 225;
int goldenGreen = 120;
int goldenBlue = 40;
int earlyRed = 70;
int earlyGreen = 100;
int earlyBlue = 150;
int basicRed = 125;
int basicGreen = 160;
int basicBlue = 200;
int noonRed = 185;
int noonGreen = 220;
int noonBlue = 250;
int cloudyRed = 95;
int cloudyGreen = 115;
int cloudyBlue = 150;
int nightRed = 15;
int nightGreen = 40;
int nightBlue = 100;
int counter = 0;
int diff = 0;
PrintWriter output;
// int[] hours =       {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24};
// float[] sun.getInt =  {0, 0, 1, 2, 4, 5, 6, 8, 8, 9, 10, 10, 10,  7,  4,  4,  6,  5,  4,  2,  1,  0,  0,  0};
// simulating a bright morning and rainy/overcast afternoon
int[] hourValues;

import java.time.LocalDateTime; // Import the LocalDateTime class
import java.time.format.DateTimeFormatter; // Import the DateTimeFormatter class 

void setup() {
  size(200, 200);
  frameRate(24000);
  background(0);
  // sun = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-08-17T16%3A00&rToDate=2022-08-17T19%3A00&rFamily=weather&rSensor=SV", "csv");
  sun = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-01-01T13%3A01%3A11&rToDate=2022-01-01T13%3A01%3A11&rFamily=weather&rSensor=SR", "csv");
  println("Getting data from API...");
  
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

  hourValues = new int[sun.getRowCount()];

  println("Parsing dates and times...");
  for (int i=0; i<sun.getRowCount(); i++) {

    //Gets hour from first row of sun table
    TableRow row = sun.getRow(i);

    //Gets dates from first row of sun table
    String myDate = row.getString(0);

    //Parses out date and time to get hour value
    LocalDateTime myDateTime = LocalDateTime.parse(myDate, formatter);

    println(myDateTime.getHour());  
    hourValues[i] = myDateTime.getHour();

  }   
  
  println("Done parsing.");
}
//1000 / 20fps -> 50ms
//1000 / 60fps -> 16.667 ms

void draw() {
    
    // This block doesn't work properly yet. The program still encounters an arrayIndexyOutOfBoundsException: 104838 error whether or not this is active.
    //if (counter >= 104838) {
    //   noLoop();
    //   text("End of data set.", 100, 100);
    //}
    
    // println("counter is: " + counter);
    diff = 12 - hourValues[counter];
    if (diff < 0) {
        diff = diff * -1;
    }
    
    // IF THE VOLTAGE IS AT THIS LOW RANGE, SET THE BACKGROUND COLOR TO DARK BLUE
    if (sun.getInt(counter, 1) >= 0 && sun.getInt(counter, 1) < 50) {
        println("Voltage1: " + sun.getInt(counter, 1));
        // background(nightRed, nightGreen, nightBlue);
        background(nightRed *(12 - diff)/12, nightGreen *(12 - diff)/12, nightBlue *(12 - diff)/12);
        println("Dark blue");
        output = createWriter("Dark blue");
        test = 1;
    }
    
    // <O> IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 4 AM AND 7 AM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    else if (hourValues[counter] >= 4 && hourValues[counter] <= 7) {
        println("sun.getInt: " + sun.getInt(counter, 1));
        diff = diff * -1;
        background( (nightRed+goldenRed)/2 * (12 - diff)/12, (nightGreen+goldenGreen)/2 * (12 - diff)/12, (nightBlue+goldenBlue)/2 * (12 - diff)/12);
        // background(goldenRed, goldenGreen, goldenBlue);
        println("Orangish");
        output = createWriter("Orangish");
        diff = diff * -1;
        test = 2;
    }
        
    //} else if (sun.getInt(counter, 1) >= 5 && sun.getInt(counter, 1) < 14 && sun.getInt(counter, 0) >= 05:00:00 && counter <= 06:00:00) {
    //    println("sun.getInt: " + sun.getInt(counter, 1));
    //    diff = diff * -1;
    //    background( (nightRed+goldenRed)/2 * (12 - diff), (nightGreen+goldenGreen)/2 * (12 - diff), (nightBlue+goldenBlue)/2 * (12 - diff));
    //    diff = diff * -1;
    //    test = 2;

// <O> IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 4 PM AND 7 PM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    else if (hourValues[counter] >= 16 && hourValues[counter] <= 19) {
        println("sun.getInt: " + sun.getInt(counter, 1));
        background((earlyRed+goldenRed)/2 * (12 - diff)/12, (earlyGreen+goldenGreen)/2 * (12 - diff)/12, (earlyBlue+goldenBlue)/2 * (12 - diff)/12);
        // background(goldenRed, goldenGreen, goldenBlue); 
        println("Orangish");
        output = createWriter("Orangish");
        test = 2;
    }
        
    // <O> IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 4 PM AND 7 PM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    else if (hourValues[counter] >= 16 && hourValues[counter] <= 19) {
        println("sun.getInt: " + sun.getInt(counter, 1));
        background((earlyRed+goldenRed)/2 * (12 - diff)/12, (earlyGreen+goldenGreen)/2 * (12 - diff)/12, (earlyBlue+goldenBlue)/2 * (12 - diff)/12);
        // background( goldenRed, goldenGreen, goldenBlue);
        println("Orangish");
        output = createWriter("Orangish");
        test = 2;
    }

    //} else if (sun.getInt(counter, 1) >= 8 && sun.getInt(counter, 1) < 14 && sun.getInt(counter, 0) >= 17:00:00 && sun.getInt(counter, 0) <= 18:00:00) {
    //    println("sun.getInt: " + sun.getInt(counter, 1));
    //    background( (nightRed+goldenRed)/2 * (12 - diff), (nightGreen+goldenGreen)/2 * (12 - diff), (nightBlue+goldenBlue)/2 * (12 - diff));
    //    test = 2;
    
// IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* IT IS NOT SUNRISE NOR SUNSET, SET THE BACKGROUND COLOR TO A CLOUDY BLUISH GRAY    
    else if (sun.getInt(counter, 1) >= 50 && sun.getInt(counter, 1) < 100) {
        println("Voltage3: " + sun.getInt(counter, 1));
        background(cloudyRed* (12 - diff)/12, cloudyGreen* (12 - diff)/12, cloudyBlue* (12 - diff)/12);
        // background(cloudyRed, cloudyGreen, cloudyBlue);
        println("Grayish");
        output = createWriter("Grayish");
        test = 3;
    }
        
// IF THE VOLTAGE IS AT THIS SLIGHTLY HIGH RANGE, SET THE BACKGROUND COLOR TO SLIGHT BLUE    
    else if (sun.getInt(counter, 1) >= 100 && sun.getInt(counter, 1) <= 200) {
        println("Voltage4: " + sun.getInt(counter, 1));
        background(earlyRed* (12 - diff)/12, earlyGreen* (12 - diff)/12, earlyBlue* (12 - diff)/12);
        // background(earlyRed, earlyGreen, earlyBlue);
        println("Slight blue");
        output = createWriter("Bright blue");
        test = 4;
        
    } 

// IF THE VOLTAGE IS AT THIS HIGH RANGE, SET THE BACKGROUND COLOR TO BRIGHT BLUE    
    else if (sun.getInt(counter, 1) >= 200 && sun.getInt(counter, 1) <= 300) {
        println("Voltage4: " + sun.getInt(counter, 1));
        background(basicRed* (12 - diff)/12, basicGreen* (12 - diff)/12, basicBlue* (12 - diff)/12);
        // background(earlyRed, earlyGreen, earlyBlue);
        println("Bright blue");
        output = createWriter("Bright blue");
        test = 4;
        
    } 
    
// IF THE VOLTAGE IS AT THIS VERY HIGH RANGE, SET THE BACKGROUND COLOR TO BRIGHTEST BLUE    
    else if (sun.getInt(counter, 1) >= 300 && sun.getInt(counter, 1) <= 400) {
        println("Voltage4: " + sun.getInt(counter, 1));
        background(noonRed* (12 - diff)/12, noonGreen* (12 - diff)/12, noonBlue* (12 - diff)/12);
        // background(earlyRed, earlyGreen, earlyBlue);
        println("Brightest blue");
        output = createWriter("Bright blue");
        test = 4;
        
    } 
    
    counter += 1;

}
