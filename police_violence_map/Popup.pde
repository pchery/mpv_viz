class Popup{
  
  boolean exit_clicked = true; 

  
  Case c;
  float rect_w = 200;
  float rect_h = 150;
  
  Popup(Case c){
    this.c = c;
  }
  
  void display(){
     rectMode(CENTER);
     noFill(); 
     rect(c.pos.x, c.pos.y,rect_w, rect_h);
     fill(255);
     rect(c.pos.x, c.pos.y,rect_w, rect_h);
     rectMode(CORNER);
     fill(0);
     textAlign(LEFT);
     
     int i = 0;
     for (Map.Entry<String, String> entry : c.attrib.entrySet()) {
       text(entry.getKey() + ": " + entry.getValue(), 5 + c.pos.x - rect_w/2, c.pos.y - rect_h/2 + textAscent() + textDescent() + 15 * i);
       i++;
     }
     textAlign(CENTER);
     
    
     fill(255);
     rect(c.pos.x + rect_w/2 - 15, c.pos.y - rect_h/2, 15,15);
     line(c.pos.x + rect_w/2 - 15, c.pos.y - rect_h/2, c.pos.x + rect_w/2,  c.pos.y - rect_h/2 + 15);
     line(c.pos.x + rect_w/2 -15, c.pos.y - rect_h/2 + 15, c.pos.x + rect_w/2,  c.pos.y - rect_h/2 );
     
  }
  
  void onClicked(float x, float y){
    if(x > c.pos.x + rect_w/2 - 15 && x < c.pos.x + rect_w/2 && y > c.pos.y - rect_h/2 && y < c.pos.y - rect_h/2 + 15){
      exit_clicked = !exit_clicked; 
      c.clicked = false;
    }   
  }
  
  
}