class ZoomWidget{
  float x; 
  float y;
  float dim = 30;
  float pad = 5;
  
 ZoomWidget(float x, float y){
   this.x = x;
   this.y = y;  
 }
  
  void display(){
    fill(255);
    rect(x,y, dim, dim);
    rect(x,y + dim, dim,dim);
    strokeWeight(3.5);
    line(x + 0.5*dim, y + pad, x + 0.5*dim, y + dim - pad);
    line(x + pad, y + 0.5*dim, x + dim - pad, y + 0.5*dim);
    line(x + pad, y + 1.5*dim, x + dim - pad, y + 1.5*dim);
    strokeWeight(1);
  }

  boolean plusClicked(){
   return ((mouseX > x && mouseX < x + dim) && (mouseY > y) && (mouseY < y + dim));
  }
  
  boolean minusClicked(){
   return ((mouseX > x && mouseX < x + dim) && (mouseY > y + dim) && (mouseY < y + 2*dim));
  }
  
}