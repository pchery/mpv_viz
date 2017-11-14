class Case{
  
  String name;
  String date;
  float latitude;
  float longitude;
  Location location;
  ScreenPosition pos;
  
  Case(float lon, float lat){
    latitude = lat;
    longitude = lon;
    location = new Location(lon, lat);
    pos = map.getScreenPosition(location); 
  }
   
  void display(){
    ellipse(pos.x, pos.y, 2, 2);
    fill(255,0,0);
  }
}