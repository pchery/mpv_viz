class BarChart{
  float x;
  float y;
  float container_w;
  float container_h = 100;
  float bar_w = 50;
  float bar_h;
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
   rect(x, y, container_w, container_h + 4*(textAscent() + textDescent())); 
   
    int i = 0;
    for(TableRow tr : rows.rows()){
       bar_h = container_h*attrib_count.get(tr.getString(1))/cases_displayed;
       fill(color(unhex(tr.getString(2))));
       rect(x + i*(bar_pad + bar_w ) + bar_pad, y + (container_h - bar_h),bar_w,bar_h); 
       fill(0);
       if(filterValue.equals("Age")){
         int age = Integer.valueOf(tr.getString(1));
         text(age - 10 + " - " + age , x + i*(bar_pad + bar_w )+ bar_pad + bar_w/2, y + container_h + 2*textAscent() + textDescent());
       }else{
         text(tr.getString(1).replaceAll(" ", "\n"), x + i*(bar_pad + bar_w )+ bar_pad + bar_w/2, y + container_h + 2*textAscent() + textDescent());
       }
       i++; 
    }
  
  
  }
  
  
  
  
  
  
}