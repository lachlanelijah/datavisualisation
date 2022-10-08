class People{
  
  float xPos;
  float spacing;
  //int speed;
  
  People(float spacing){
    xPos = 899;                            
    this.spacing = spacing;
  }
  
  void drawCircle(){
     fill(#FF0808);
     circle(xPos+spacing, height-220, 65);
     
     //circle((speedo*175)+spacing, height-220, 65);
  }
  
  void decreaseSpeed(float speedo){
    //xPos -= 7;
    int speed = Math.round(speedo);
    switch (speed) {
      case 1:
        xPos -= speedo + 4;
        break;
      case 2:
        xPos -= speedo + 4;
        break;
      case 3: 
        xPos -= speedo + 3;
        break;
      case 4:
        xPos -= speedo + 2;
        break;
      default:
        xPos -= speedo + 1;
    }
    //xPos -= speedo + 1;
    
    
  }
  
}
