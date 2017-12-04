class Legend{
  int num_attrib;
  int rect_width = 50;
  int rect_height = 25;
  int x_pad = 5;
  int y_pad = 5;
  String name;

  Legend(String name , int num_attrib){
    this.num_attrib = num_attrib;
    this.name = name;
  }
  
  void display(){
    fill(255);
    rect(width - 25 - (rect_width + 2*x_pad)*num_attrib + x_pad, height - 125, (rect_width + 2*x_pad) * num_attrib, rect_height + 2*y_pad + textAscent() + textDescent()); 
    
    for(int i = num_attrib; i > 0; i--){
      rect(width - 25 - (rect_width + x_pad)*i, height - 125 + y_pad, rect_width, rect_height);
      fill(0);
      textAlign(CENTER);
      text("hello", width - 25 - (rect_width + x_pad)*i + rect_width/2, height - 125 + y_pad + rect_height + textAscent() + textDescent());
      fill(255);
    }
    
    
  }
}