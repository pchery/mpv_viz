class BarChart{
  float x;
  float y;
  float container_w;
  float container_h = 100;
  float bar_w = 20;
  float bar_h;
  String filterValue;
  int num_attrib;
  Table rows;
  
  
  BarChart(String filterValue, float x, float y){
    this.x = x;
    this.y = y;
    this.filterValue = filterValue;
    this.rows = new Table(colormap.findRows(filterValue, 0));
    this.num_attrib = rows.getRowCount();
   
  }
  
  void display(){
   fill(255);
    int i = 0;
    for(TableRow tr : rows.rows()){
       bar_h = container_h*attrib_count.get(tr.getString(1))/cases_displayed;
       fill(color(unhex(tr.getString(2))));
       rect(axis.x_pos-25, (axis.y_pos-200)+i*bar_w, bar_h, bar_w);
       fill(0);
       i++; 
    }
  
  
  }
  
  
  
  
  
  
}