class Legend{
  int num_attrib;
  int rect_width = 50;
  int rect_height = 25;
  int x_pad = 15;
  int y_pad = 5;
  String name;
  Table cmap;

  Legend(String name , Iterable<TableRow> tr){
    this.name = name;
    this.cmap = new Table(tr);
    this.num_attrib = cmap.getRowCount();
  }
  
  void display(){
    fill(255);
    rect(width - 10 - (rect_width + x_pad)*num_attrib - x_pad, 7, (rect_width + x_pad) * num_attrib + x_pad, rect_height + 2*y_pad + 2*(textAscent() + textDescent())); 
    
    int i = num_attrib;
    for(TableRow tr : cmap.rows()){
      fill(color(unhex(tr.getString(2))));
      rect(width - 10 - (rect_width + x_pad)*i, 7 + y_pad, rect_width, rect_height);
      fill(0);
      textAlign(CENTER);
      textSize(9);
      if(name.equals("Age")){
         int age = Integer.valueOf(tr.getString(1));
         text(age - 10 + " - " + age , width - 7 - (rect_width + x_pad)*i + rect_width/2, 10 + y_pad + rect_height + textAscent() + textDescent());
      }else{
        text(tr.getString(1).replaceAll(" ", "\n"), width - 7 - (rect_width + x_pad)*i + rect_width/2, 10 + y_pad + rect_height + textAscent() + textDescent());
      }
      textSize(10);
      i--;
    }
    
    
  }
}