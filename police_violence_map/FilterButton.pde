class FilterButton {
  
  boolean clicked = false;
  float x;
  float y;
  String label;
  Legend legend; 
  
  Map<String, Map> colormaps = new HashMap<String, Map>();
  Map<String, String> genderCM = new HashMap<String, String>(); 
  Map<String, String> ageCM = new HashMap<String, String>();
  Map<String, String> raceCM = new HashMap<String, String>();
  
  //filter button should have a colormap object
   //filter button tells cases and legend which colors to use
  //filter button has a legend 
  
  FilterButton(String label, float x, float y){
    this.label = label;
    this.x = x;
    this.y = y;
    
    genderCM.put("Male","FF0000FF");
    genderCM.put("Female","FFFF0000");
    genderCM.put("NA","FFFF0000");
    genderCM.put("Transgender","FFFF0000");
    genderCM.put("Unknown","FFFF0000");
    raceCM.put("Black", "ff123456");
    raceCM.put("White", "ff654321");
    raceCM.put("Hispanic", "ffffff");
    raceCM.put("Native American", "ffffff");
    raceCM.put("Unknown race", "ffffff");
    raceCM.put("Pacific Islander", "ffffff");
    raceCM.put("Asian", "ffffff");
    
    colormaps.put("Gender", genderCM);
    colormaps.put("Race", raceCM);
    
    legend = new Legend(label, 3);
  }
  
  void display(){
    if(clicked){
     legend.display();
     fill(122,122,122); 
    }else{
     fill(255); 
    }
    float x_pad = 15;
    float y_pad = 3;
    rect(x - x_pad, y - y_pad, textWidth(label) + 2*x_pad, textAscent() + textDescent() + 2*y_pad);
    fill(0);
    text(label, x + (textWidth(label))/2, y + textAscent());
  }
  
  boolean onClicked(float pos_x, float pos_y){
    if((pos_x > x && pos_x < x + 50) && (pos_y > y && pos_y < y + 20)){
      clicked = !clicked;
    }
    
    return clicked;
  }
  
  
  
}