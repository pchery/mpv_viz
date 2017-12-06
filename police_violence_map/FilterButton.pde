class FilterButton {
  float w = 100; 
  boolean highlighted;
  float x;
  float y;
  String label;
  Legend legend; 
  
  FilterButton(String label, float x, float y){
    this.label = label;
    this.x = x;
    this.y = y;
    
    legend = new Legend(label, colormap.findRows(label,0));
    highlighted = false;
  }
  
  void display(){
    if(highlighted){
     legend.display();
     fill(122,122,122); 
    }else{
     fill(255); 
    }
    float x_pad = 15;
    float y_pad = 3;
    rect(x - x_pad, y - y_pad, w, textAscent() + textDescent() + 2*y_pad);
    fill(0);
    text(label, x - x_pad + w/2, y + textAscent());
  }
  
  boolean onClicked(float pos_x, float pos_y){
    if((pos_x > x && pos_x < x + 50) && (pos_y > y && pos_y < y + 20)){
     return true;
    }
    return false;
  }
  
  
  
}