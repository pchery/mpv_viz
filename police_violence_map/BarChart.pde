class BarChart{
  float x;
  float y;
  float container_w;
  float container_h = 150;
  float bar_w = 50;
  float bar_pad = 10;
  String filterValue;
  int num_attrib;
  Table rows;
  
  
  BarChart(String filterValue, float x, float y){
    this.x = x;
    this.y = y;
    this.filterValue = filterValue;
    this.rows = new Table(colormap.findRows(filterValue, 0));
    this.num_attrib = rows.getRowCount();
    this.container_w = num_attrib*(bar_w + bar_pad) + bar_pad;
   
  }
  
  void display(){
   fill(255);
   rect(x, y, container_w, container_h); 
   
    int i = 0;
    for(TableRow tr : rows.rows()){
       fill(color(unhex(tr.getString(2))));
       rect(x + i*(bar_pad + bar_w ) + bar_pad, y + (container_h - 50),bar_w,50); 
       fill(0);
       text(tr.getString(1).replaceAll(" ", "\n"), x + i*(bar_pad + bar_w )+ bar_pad + bar_w/2, y + (container_h - 50) - 2*textAscent() - textDescent());
       i++; 
    }
  
  
  }
  
  
  
  
  
  
}