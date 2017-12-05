import java.util.Map;
class Case{
  
  String name;
  float latitude;
  float longitude;
  Location location;
  ScreenPosition pos;
  boolean displayed;
  boolean clicked;
  Date date;
  String s_date;
  String race;
  String age;
  String gender;
  String state;
  Popup popup;
  Map<String, String> attrib = new HashMap<String,String>();
  String filterValue;
  int wave_rad;
  boolean wave_on;
  Case(float lon, float lat, String name, String date, String race, String age, String gender, String state){
  
    wave_rad = 0;
    wave_on = true;
    clicked = false;    
    displayed = false;
    
    filterValue = "";
    attrib.put("Name", name);
    attrib.put("Race", race);
    attrib.put("Gender", gender);
    attrib.put("State", state);
    //attrib.put("Age", age);
    this.state = state;
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
    if(wave_rad > 50){
       wave_rad = 0;
       wave_on = false;
    }
    this.pos = pos;
    float rect_w = 200;
    float rect_h = 150;
    if (!clicked){
      if(!filterValue.equals("")){
        color c = unhex(colormap.findRow(attrib.get(filterValue), 1).getString(2));
        fill(c);
      }else{
        fill(100,100,100);
      }

      ellipse(pos.x, pos.y, marker_rad, marker_rad);
    }
    fill(255,0);
    ellipse(pos.x, pos.y, wave_rad, wave_rad);
    if(wave_on){
      wave_rad += 2;
    }
  }
  
  boolean onClicked(float x_pos, float y_pos){
    if((x_pos > pos.x - marker_rad &&  x_pos < pos.x + marker_rad) && (y_pos > pos.y - marker_rad &&  y_pos < pos.y + marker_rad)){
      clicked = !clicked;
    }
    return clicked;

  
  }
}