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

import java.text.SimpleDateFormat;  
import java.util.Date;
import java.text.ParseException;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;

Axis axis;
JSONArray c; 
FilterButton[] filterButtons;
import java.util.*;
Case[] cases;
Location usaLocation = new Location(39.50, -98.35);
int marker_rad = 10;
Case popup_displayed; 
FilterButton selected_fb;
Table colormap; 
Table table;
ZoomWidget zoom;
Map<String, Integer> attrib_count;
int cases_displayed;
EventDispatcher eventDispatcher;
void setup(){
  //size(800,700,P2D);
  frameRate(10);
  fullScreen(P2D);
  
  popup_displayed = null;
  selected_fb = null;
  //map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
  //map = new UnfoldingMap(this, new Microsoft.HybridProvider() );
  //map = new UnfoldingMap(this, new Google.GoogleTerrainProvider() );
  //map = new UnfoldingMap(this, new Google.GoogleSimplifiedProvider() );
  //map = new UnfoldingMap(this, new GeoMapApp.TopologicalGeoMapProvider() );
  //map = new UnfoldingMap(this, new EsriProvider.WorldStreetMap() );
  //map = new UnfoldingMap(this, new EsriProvider.WorldGrayCanvas() ); I really like this one, except there are no city names
  //map = new UnfoldingMap(this, new EsriProvider.NatGeoWorldMap() );
  //map = new UnfoldingMap(this, new OpenStreetMap.OSMGrayProvider() );
  map = new UnfoldingMap(this, new StamenMapProvider.TonerLite() ); //I really like this one
  
  map.zoomAndPanTo(usaLocation, 4);
  map.setZoomRange(4, 15);
  map.setTweening(true);
  loadData();
  attrib_count = new HashMap<String, Integer>();
  filterButtons = new FilterButton[3];
  filterButtons[2] = new FilterButton("Age", 25, 10);
  filterButtons[0] = new FilterButton("Race", 100, 10);
  filterButtons[1] = new FilterButton("Gender", 175, 10);
  axis = new Axis(50,height-35,width-50);
  zoom = new ZoomWidget(width - 40, height - 150);
  eventDispatcher = new EventDispatcher();
  MouseHandler mouseHandler = new MouseHandler(this, map);
  eventDispatcher.addBroadcaster(mouseHandler);
  eventDispatcher.register(map, PanMapEvent.TYPE_PAN, map.getId());
  eventDispatcher.register(map, ZoomMapEvent.TYPE_ZOOM, map.getId());
  //eventDispatcher.unregister(map, PanMapEvent.PAN_BY, map.getId());
 // eventDispatcher.register(map, ZoomMapEvent.TYPE_ZOOM, map.getId());
}


void draw(){
  background(0);
  map.draw();
  if(selected_fb != null){
    for(TableRow tr : colormap.findRows(selected_fb.label, 0)){
      //print(tr.getString(1) + "\n");
      attrib_count.put(tr.getString(1), 0);
    }
  }
  cases_displayed = 0;
  for(Case c:cases){
    if(axis.displayCase(c)) {
      cases_displayed++;
      ScreenPosition pos = map.getScreenPosition(c.location);
      if(selected_fb != null){
        c.filterValue = selected_fb.label;
        //print(attrib_count.get(c.attrib.get(c.filterValue))+ "\n");
        if(c.filterValue.equals("Age")){
          if(!c.attrib.get(c.filterValue).equals("Unknown") && !c.attrib.get(c.filterValue).equals("NA")){
            double age = Math.ceil(Integer.valueOf(c.attrib.get(c.filterValue).replace("s", ""))/10.0)*10;
            if(age < 90){
              attrib_count.put(String.valueOf((int)age), attrib_count.get(String.valueOf((int)age)) + 1);
            }
            if(age >= 90){
              attrib_count.put("90", attrib_count.get("90") + 1);
            }
          }
        }else{
          attrib_count.put(c.attrib.get(c.filterValue), attrib_count.get(c.attrib.get(c.filterValue)) + 1);
        }
      }
      else {
        c.filterValue = "";
      }
      c.displayed = true; 
      c.display(pos);
    }
    else {
     c.displayed = false; 
   }
  }
  axis.draw();
  if(axis.playButton.play) {
    axis.playWidget.drag(axis.playWidget.x_pos+axis.day_unit);
  }
  
 
  for(FilterButton fb: filterButtons){
    fb.display();
  }
  zoom.display();
  if(selected_fb != null){
    selected_fb.display();
  }
  if(popup_displayed != null){
    popup_displayed.popup.display();
    if(!popup_displayed.clicked){
      popup_displayed = null;
    } 
  }
}

void loadData(){
  colormap = loadTable("attributes.csv");
  print(colormap.findRows("Gender", 0));
  table = loadTable("CleanMPVDataset.csv", "header");
  cases = new Case[table.getRowCount()];
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow r = table.getRow(i);
    cases[i] = new Case(r.getFloat("latitude"), r.getFloat("longitude"), r.getString("name"), r.getString("date"), r.getString("race"), r.getString("age"), r.getString("gender"),r.getString("state"), r.getString("alleged_weapon"), r.getString("cause"),r.getString("agency")); 
  }
  
  
}

void mouseMoved(){
 
}
void mouseClicked(MouseEvent evt){
   //eventDispatcher.register(map, PanMapEvent.PAN_UP, map.getId());
  if(zoom.plusClicked()){
    map.zoomAndPanTo(width/2, height/2, map.getZoomLevel() + 1);
  }else if(zoom.minusClicked()){
     map.zoomAndPanTo(width/2, height/2, map.getZoomLevel() - 1);
  }
 
  for(FilterButton fb: filterButtons){
    if(selected_fb == null && fb.onClicked(mouseX, mouseY)){
      selected_fb = fb;
      fb.highlighted = true;
    }
    else if(selected_fb != null && fb.onClicked(mouseX, mouseY) && fb.equals(selected_fb)){
      selected_fb.highlighted = false;
      selected_fb = null;
    }
    else if(selected_fb != null && fb.onClicked(mouseX, mouseY) && !fb.equals(selected_fb)){
      selected_fb.highlighted = false;
      selected_fb = fb;
      selected_fb.highlighted = true;
    }
  }
  for(Case ca : cases){
    if(ca.displayed){
      ca.popup.onClicked(mouseX, mouseY);
      if(popup_displayed == null && ca.onClicked(mouseX, mouseY)){
        popup_displayed = ca;
      }
    }
  }
  if (axis.playButton.clicked()) {
    axis.playButton.resetPlay();
  }
  else if (axis.clicked()) {
    axis.minSliderButton.x_pos = mouseX;
    axis.playWidget.display = false;
    axis.playWidget.x_pos = axis.minSliderButton.x_pos;
    axis.playButton.play = false;
    axis.resetCaseWaving();
  }
  
}

void mouseDragged(){
  if (axis.minSliderButton.clicked() || axis.minSliderButton.clicked) {
    axis.minSliderButton.clicked = true;
    axis.minSliderButton.drag(mouseX);
    axis.playWidget.x_pos = axis.minSliderButton.x_pos;
    axis.playWidget.display = false;
    axis.resetCaseWaving();
    axis.playButton.play = false;
    popup_displayed = null;
  }
}

void mouseReleased(){
  if (this.filterButtons[0].onClicked(mouseX, mouseY) || this.filterButtons[1].onClicked(mouseX, mouseY) || this.filterButtons[2].onClicked(mouseX, mouseY) || axis.playButton.clicked() || axis.clicked() ||
      axis.minSliderButton.clicked() || axis.minSliderButton.clicked) {
     listen(); 
  }
  axis.minSliderButton.clicked = false;
}

void listen() {
  eventDispatcher.register(map, PanMapEvent.TYPE_PAN, map.getId());
}

void mute() {
    eventDispatcher.unregister(map, PanMapEvent.TYPE_PAN, map.getId());
}

public void mousePressed() {
  if (this.filterButtons[0].onClicked(mouseX, mouseY) || this.filterButtons[1].onClicked(mouseX, mouseY) || this.filterButtons[2].onClicked(mouseX, mouseY) || axis.playButton.clicked() || axis.clicked() || 
      axis.minSliderButton.clicked() || axis.minSliderButton.clicked) {
    mute(); 
   }
}

public void mouseWheel(){
  eventDispatcher.register(map, ZoomMapEvent.TYPE_ZOOM, map.getId());
}