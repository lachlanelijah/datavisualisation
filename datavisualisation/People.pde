class People{
  
  float xPos;
  float xPos2;
  float spacing;
  //int speed;
  
  People(float spacing){
    xPos = 899; 
    xPos2 = 1;
    this.spacing = spacing;
  }
  
  void drawCircle(int scene){
    switch (scene) {
      case 1:
        fill(#FF0808);
        circle(xPos+spacing, height-220, 65);
        break;
      case 2:
        fill(#39FF14);
        circle(xPos2-spacing, height-220, 65);
        break;
    }
    
    
    //circle(xPos+spacing, height-220, 65);
     
    //circle((speedo*175)+spacing, height-220, 65);
  }
  
  void decreaseSpeed1(float speedo){
    //xPos -= 7;
    int speed = Math.round(speedo);
      switch (speed) {
        case 1:
          xPos -= speedo + 5;
          break;
        case 2:
          xPos -= speedo + 5;
          break;
        case 3: 
          xPos -= speedo + 4;
          break;
        case 4:
          xPos -= speedo + 3;
          break;
        default:
          xPos -= speedo + 3;
      }
  }
  void decreaseSpeed2(float speedo){
    //xPos -= 7;
    int speed = Math.round(speedo);
      switch (speed) {
        case 1:
          xPos2 += speedo + 5;
          break;
        case 2:
          xPos2 += speedo + 5;
          break;
        case 3: 
          xPos2 += speedo + 4;
          break;
        case 4:
          xPos2 += speedo + 3;
          break;
        default:
          xPos2 += speedo + 3;
      }
  }
  
}
