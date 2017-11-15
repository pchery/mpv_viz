class Case{
  
  String name;
  float latitude;
  float longitude;
  Location location;
  ScreenPosition pos;
  boolean clicked = false;
  Date date;
  String s_date;
  
  Case(float lon, float lat, String date){
    latitude = lat;
    longitude = lon;
    location = new Location(lon, lat);
    pos = map.getScreenPosition(location);
    s_date = date;
    try{
      this.date = new SimpleDateFormat("yyyy-MM-dd").parse(date);
    } catch(ParseException ex) {}
    
  }
   
  void display(){
  }
  
  void onClicked(float x_pos, float y_pos){
    if((x_pos > pos.x - marker_rad &&  x_pos < pos.x + marker_rad) && (y_pos > pos.y - marker_rad &&  y_pos < pos.y + marker_rad)){
      clicked = true;
    }
    
  }
}