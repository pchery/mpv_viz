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
  float wave_stroke_weight=3;
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
    attrib.put("Date", date);
    attrib.put("Age", age);
    this.state = state;
    this.name = name;
    this.race = race;
    this.age = age;
    this.gender = gender;
    this.popup = new Popup(this);
    this.latitude = lat;
    this.longitude = lon;
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
        color c = #aaaaaa;
        if(filterValue.equals("Age")){
          if(!attrib.get(filterValue).equals("Unknown") && !attrib.get(filterValue).equals("NA")){
            double age = Math.ceil(Integer.valueOf(attrib.get(filterValue).replace("s", ""))/10.0)*10;
            if(age < 90){
              c = unhex(colormap.findRow(String.valueOf((int)age), 1).getString(2));
            }
            if(age >= 90){
               c = unhex(colormap.findRow("90", 1).getString(2));
            }
          }
        }else{
          c = unhex(colormap.findRow(attrib.get(filterValue), 1).getString(2));
        }
        fill(c);
      }else{
        fill(100,100,100);
      }
      strokeWeight(1);
      ellipse(pos.x, pos.y, marker_rad, marker_rad);
    }
    fill(255,0);
    strokeWeight(wave_stroke_weight);
    ellipse(pos.x, pos.y, wave_rad, wave_rad);
    strokeWeight(1);
    if(wave_on && axis.playButton.play){
      wave_rad += 4;
      wave_stroke_weight -= 0.2;
    }
  }
  
  boolean onClicked(float x_pos, float y_pos){
    if((x_pos > pos.x - marker_rad &&  x_pos < pos.x + marker_rad) && (y_pos > pos.y - marker_rad &&  y_pos < pos.y + marker_rad)){
      clicked = !clicked;
    }
    return clicked;

  
  }
}