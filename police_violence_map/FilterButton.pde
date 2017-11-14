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
     fill(255,0,0); 
    }else{
     fill(0); 
    }
    float x_pad = 5;
    rect(x - x_pad, y , textWidth(label) + 2*x_pad, textAscent() + textDescent());
    fill(255);
    text(label, x, y + textAscent() );
  }
  
  void onClicked(float pos_x, float pos_y){
    if((pos_x > x && pos_x < x + 50) && (pos_y > y && pos_y < y + 20)){
      clicked = !clicked;
    }
  }
  
  
  
}