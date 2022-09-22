import beads.*;
import controlP5.*;

void setup() {
  size(900, 800);
  noStroke();
  background(178, 224, 245);
  frameRate(60);
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
  
  text("timeTest", 770, 100);
}
