class FilterButton {
  
  boolean clicked = false;
  float x;
  float y;
  String label;
  
  FilterButton(String label, float x, float y){
    this.label = label;
    this.x = x;
    this.y = y;
  }
  
  void display(){
    if(clicked){
     fill(122,122,122); 
    }else{
     fill(255); 
    }
    float x_pad = 10;
    float y_pad = 3;
    rect(x - x_pad, y - y_pad, textWidth(label) + 2*x_pad, textAscent() + textDescent() + 2*y_pad);
    fill(0);
    text(label, x, y + textAscent() );
  }
  
  void onClicked(float pos_x, float pos_y){
    if((pos_x > x && pos_x < x + 50) && (pos_y > y && pos_y < y + 20)){
      clicked = !clicked;
    }
  }
  
  
  
}