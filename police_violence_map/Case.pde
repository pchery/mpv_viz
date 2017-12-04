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
  
  Map<String, Map> colormaps = new HashMap<String, Map>();
  Map<String, String> genderCM = new HashMap<String, String>(); 
  Map<String, String> ageCM = new HashMap<String, String>();
  Map<String, String> raceCM = new HashMap<String, String>();
  
  Case(float lon, float lat, String name, String date, String race, String age, String gender, String state){
  
    
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
    //colormaps.put("Age", ageCM);
    
  }
   
  void display(ScreenPosition pos){
    this.pos = pos;
    float rect_w = 200;
    float rect_h = 150;
    if (!clicked){
      if(!filterValue.equals("")){
        //color c = (int)colormaps.get(filterValue).get(attrib.get(filterValue));
        //print(colormaps.get(filterValue).get(attrib.get(filterValue)));
        //print(colormaps.get(filterValue).get(attrib.get(filterValue)).getClass());
        color c = unhex(colormaps.get(filterValue).get(attrib.get(filterValue)).toString());
        fill(c);
      }else{
        fill(100,100,100);
      }
      //print(filterValue);
      //fill(c);
      ellipse(pos.x, pos.y, marker_rad, marker_rad);
    }
    //else if(clicked){
    //   popup.display();
    //}
    
  }
  
  boolean onClicked(float x_pos, float y_pos){
    if((x_pos > pos.x - marker_rad &&  x_pos < pos.x + marker_rad) && (y_pos > pos.y - marker_rad &&  y_pos < pos.y + marker_rad)){
      clicked = !clicked;
    }
    return clicked;

  
  }
}