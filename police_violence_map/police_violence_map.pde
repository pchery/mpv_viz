import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;
UnfoldingMap map;

JSONArray c; 
ArrayList<PShape> cities;
ArrayList<State> states;
ArrayList<PVector> vertices;
Table table;
FilterButton[] filterButtons;
import java.util.*;
Case[] cases;
Location usaLocation = new Location(39.50, -98.35);

void setup(){
  size(800,800,P2D);
  states = new ArrayList<State>();
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(usaLocation, 4);
  MapUtils.createDefaultEventDispatcher(this, map);
  //cities = new ArrayList<PShape>();
  filterButtons = new FilterButton[1];
  filterButtons[0] = new FilterButton("Age", 100, 100);
  loadData();
}


void draw(){
  background(0);
  map.draw();
  //pushMatrix();
  //translate(-50, -200);
  //scale(3.0);
  
  
  //for(int z = 0; z < states.size(); z++){
  //  if(states.get(z) != null){
  //    states.get(z).display();
  //  }
  //}
  
  for(Case c:cases){
    ScreenPosition pos = map.getScreenPosition(c.location);
    fill(255,0,0);
    ellipse(pos.x, pos.y, 2,2);
  }
  for(FilterButton fb: filterButtons){
    fb.display();
  }
  
  
  //for(int z = 0; z < cities.size(); z++){
  //  if(cities.get(z) != null){
  //    shape(cities.get(z), 0,0);
  //  }
  //}
  //popMatrix();
}

void loadData(){
  
  //data obtained from https://mapzen.com/data/borders/ 
  
  //increase memory size to 2048MB for level 8
  //JSONObject state = loadJSONObject("regions.geojson");
  //JSONObject state = loadJSONObject("admin_level_4.geojson");
  //JSONObject city = loadJSONObject("admin_level_8.geojson");
  
  //JSONArray f = state.getJSONArray("features");
    
  //for(int i = 0; i < f.size(); i++){
  //  JSONArray a = f.getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
  //  states.add(new State(a));
  //}
  table = loadTable("CleanMPVDataset1.csv", "header");
  cases = new Case[table.getRowCount()];
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow r = table.getRow(i);
    cases[i] = new Case(r.getFloat("latitude"), r.getFloat("longitude")); 
  }
  
  
}

void mouseMoved(){
  
  //for(int i = 0; i<states.size(); i++){
  //  states.get(i).cursorIn(mouseX, mouseY); 
  //}
}
void mouseClicked(){
  for(FilterButton fb: filterButtons){
    fb.onClicked(mouseX, mouseY);
  }
  
}
float convertLon(float lon){
    return width*(lon + 175)/120;
  }
float convertLat(float lat){
  return (height*(1 - (lat+ 105)/180))*(180/60);
}
  