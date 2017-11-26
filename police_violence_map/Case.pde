import java.util.Map;
class Case{
  
  String name;
  float latitude;
  float longitude;
  Location location;
  ScreenPosition pos;
  boolean clicked = false;
  Date date;
  String s_date;
  String race;
  String age;
  String gender;
  Popup popup;
  Map<String, String> attrib = new HashMap<String,String>();
  
  Case(float lon, float lat, String name, String date, String race, String age, String gender){
    attrib.put("Name", name);
    attrib.put("Race", race);
    attrib.put("Gender", gender);
    attrib.put("Age", age);
    
    this.name = name;
    this.race = race;
    this.age = age;
    this.gender = gender;
    this.popup = new Popup(this);
    latitude = lat;
    longitude = lon;
    location = new Location(lon, lat);
    pos = map.getScreenPosition(location);
    s_date = date;
    try{
      this.date = new SimpleDateFormat("yyyy-MM-dd").parse(date);
    } catch(ParseException ex) {}
    
  }
   
  void display(ScreenPosition pos){
    this.pos = pos;
    float rect_w = 200;
    float rect_h = 150;
    if(clicked){
       popup.display();
    }else if (!clicked){
      fill(255,0,0);
      ellipse(pos.x, pos.y, marker_rad, marker_rad);
    }
    
  }
  
  void onClicked(float x_pos, float y_pos){
    if((x_pos > pos.x - marker_rad &&  x_pos < pos.x + marker_rad) && (y_pos > pos.y - marker_rad &&  y_pos < pos.y + marker_rad)){
      clicked = !clicked;
    }    
    
  }
}