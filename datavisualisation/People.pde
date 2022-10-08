class People{
  
  float xPos;
  float spacing;
  
  People(float spacing){
    xPos = 899;                            
    this.spacing = spacing;
  }
  
  void drawCircle(){
     fill(#FF0808);
     circle(xPos+spacing, height-220, 65);
  }
  
  void decreaseSpeed(){
    xPos -= 7;
    
    
  }
  
}
