class Case{
  
  String name;
  String date;
  float latitude;
  float longitude;
  Location location;
  ScreenPosition pos;
  boolean clicked = false;
  
  Case(float lon, float lat){
    latitude = lat;
    longitude = lon;
    location = new Location(lon, lat);
    pos = map.getScreenPosition(location); 
  }
   
  void display(){
  }
  
  void onClicked(float x_pos, float y_pos){
    if((x_pos > pos.x - marker_rad &&  x_pos < pos.x + marker_rad) && (y_pos > pos.y - marker_rad &&  y_pos < pos.y + marker_rad)){
      clicked = true;
    }
    
  }
}