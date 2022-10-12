class Sun{
  
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
  
  Sun(){
    
  }
  
  void drawSun(float voltage, int scene){
     if (voltage >= 0 && voltage < 4) {
        //println("Voltage1: " + sun.getInt(counter, 1));
        // background(nightRed, nightGreen, nightBlue);
        fill(nightRed *(12 - diff)/12, nightGreen *(12 - diff)/12, nightBlue *(12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Dark blue");
        test = 1;
    }
    
    // <O> IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 4 AM AND 7 AM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    else if (voltage >= 4 && voltage < 7) {
        //println("sun.getInt: " + sun.getInt(counter, 1));
        diff = diff * -1;
        fill((nightRed+goldenRed)/2 * (12 - diff)/12, (nightGreen+goldenGreen)/2 * (12 - diff)/12, (nightBlue+goldenBlue)/2 * (12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Orangish");
        diff = diff * -1;
        test = 2;
    }
        
    // <O> IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* THE TIME IS BETWEEN 4 PM AND 7 PM, SET THE BACKGROUND COLOR TO anAN AVERAGE OF THE DARK BLUE AND ORANGE VALUES    
    else if (voltage >= 7 && voltage <= 11) {
        //println("sun.getInt: " + sun.getInt(counter, 1));
        fill((earlyRed+goldenRed)/2 * (12 - diff)/12, (earlyGreen+goldenGreen)/2 * (12 - diff)/12, (earlyBlue+goldenBlue)/2 * (12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Orangish");
        test = 2;
    }
    
// IF THE VOLTAGE IS AT THIS MEDIUM RANGE *AND* IT IS NOT SUNRISE NOR SUNSET, SET THE BACKGROUND COLOR TO A CLOUDY BLUISH GRAY    
    else if (voltage >= 11 && voltage < 14) {
        //println("Voltage3: " + sun.getInt(counter, 1));
        fill(cloudyRed* (12 - diff)/12, cloudyGreen* (12 - diff)/12, cloudyBlue* (12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Grayish");
        test = 3;
    }
        
// IF THE VOLTAGE IS AT THIS SLIGHTLY HIGH RANGE, SET THE BACKGROUND COLOR TO SLIGHT BLUE    
    else if (voltage >= 14 && voltage < 18) {
        //println("Voltage4: " + sun.getInt(counter, 1));
        fill(earlyRed* (12 - diff)/12, earlyGreen* (12 - diff)/12, earlyBlue* (12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Slight blue");
        test = 4;
        
    } 

// IF THE VOLTAGE IS AT THIS HIGH RANGE, SET THE BACKGROUND COLOR TO BRIGHT BLUE    
    else if (voltage >= 18 && voltage < 20) {
        //println("Voltage4: " + sun.getInt(counter, 1));
        fill(basicRed* (12 - diff)/12, basicGreen* (12 - diff)/12, basicBlue* (12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Bright blue");
        test = 4;
        
    } 
    
// IF THE VOLTAGE IS AT THIS VERY HIGH RANGE, SET THE BACKGROUND COLOR TO BRIGHTEST BLUE    
    else if (voltage >= 20 && voltage <= 25) {
        //println("Voltage4: " + sun.getInt(counter, 1));
        fill(noonRed* (12 - diff)/12, noonGreen* (12 - diff)/12, noonBlue* (12 - diff)/12);
        switch (scene) {
          case 1:
            quad(640, 0, 640, 440, 900, 440, 900, 0);
            break;
          case 2:
            quad(330, 0, 330, 500, 900, 500, 900, 0);
            break;
        }
        //println("Brightest blue");
        test = 4;
        
    } 
  }
}
