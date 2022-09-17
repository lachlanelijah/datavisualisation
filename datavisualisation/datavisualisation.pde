import beads.*;
import controlP5.*;

void setup() {
  size(900, 800);
  noStroke();
  background(178, 224, 245);
  
  fill (59,59,59); //ground
  quad(0, 440, width, 440, width, height, 0, height);
  
  fill(7, 151, 216); // left glass
  quad(0, 400, 0, 515, 100, 510, 100, 200);
  
  fill(201, 201, 181);
  quad(485, 0, 485, 470, 300, 460, 0, 0);
  
  
  
  fill(62, 195, 255); //right glass
  quad(100, 510, 300, 475, 400, 0, 100, 200);
  
  
  fill(144,144,144); //back facade
  quad(440, 0, 400, 480, 300, 475, 300, 0);
  
  fill(193, 193, 193); //facade
  quad(0, 0, 0, 400, 350, 300, 400, 0);
  
  fill(226, 227, 206); //building 10 front
  beginShape();
  vertex(485, 0);
  vertex(485, 470);
  vertex(640, 452);
  vertex(640, 10);
  vertex(600, 0);
  endShape(CLOSE);

}

void draw() {
  
}
