class Legend{
  int num_attrib;
  int rect_width = 50;
  int rect_height = 25;
  int x_pad = 15;
  int y_pad = 5;
  String name;
  Table colormap;

  Legend(String name , Iterable<TableRow> tr){
    this.name = name;
    this.colormap = new Table(tr);
    this.num_attrib = colormap.getRowCount();
  }
  
  void display(){
    fill(255);
    rect(width - 25 - (rect_width + x_pad)*num_attrib - x_pad, height - 140, (rect_width + x_pad) * num_attrib + x_pad, rect_height + 2*y_pad + 2*(textAscent() + textDescent())); 
    
    int i = num_attrib;
    for(TableRow tr : colormap.rows()){
      fill(color(unhex(tr.getString(2))));
      rect(width - 25 - (rect_width + x_pad)*i, height - 140 + y_pad, rect_width, rect_height);
      fill(0);
      textAlign(CENTER);
      textSize(9);
      
      text(tr.getString(1).replaceAll(" ", "\n"), width - 25 - (rect_width + x_pad)*i + rect_width/2, height - 140 + y_pad + rect_height + textAscent() + textDescent());
      textSize(10);
      i--;
    }
    
    
  }
}