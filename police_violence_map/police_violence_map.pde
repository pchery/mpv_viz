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
Axis axis;

BarScaleUI barscale;
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

EventDispatcher eventDispatcher;

void setup(){
  size(800,700,P2D);
  //fullScreen(P2D);
  
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
  barscale = new BarScaleUI(this, map, 100, 700);
  filterButtons = new FilterButton[3];
  filterButtons[2] = new FilterButton("Age", 25, 10);
  filterButtons[0] = new FilterButton("Race", 150, 10);
  filterButtons[1] = new FilterButton("Gender", 275, 10);
  axis = new Axis(50,height-50,width-100);
  
  
  eventDispatcher = new EventDispatcher();
  MouseHandler mouseHandler = new MouseHandler(this, map);
  eventDispatcher.addBroadcaster(mouseHandler);
  listen();
  
}


void draw(){
  background(0);
  map.draw();
  int cases_displayed = 0;
  for(Case c:cases){
    if(axis.displayCase(c)) {
      cases_displayed++;
      ScreenPosition pos = map.getScreenPosition(c.location);
      if(selected_fb != null){
        c.filterValue = selected_fb.label;
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
  barscale.draw();
  axis.draw();
  if(axis.playButton().getPlay()) {
    axis.playWidget().drag(axis.playWidget.getXPos()+axis.getDayUnit());
  }
 
  for(FilterButton fb: filterButtons){
    fb.display();
  }
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
    cases[i] = new Case(r.getFloat("latitude"), r.getFloat("longitude"), r.getString("name"), r.getString("date"), r.getString("race"), r.getString("age"), r.getString("gender"),r.getString("state")); 
  }
  
  
}

void mouseMoved(){
 
}
void mouseClicked(){
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
  if (this.axis.playButton.clicked()) {
    this.axis.playButton.resetPlay();
  }
  else if (this.axis.clicked()) {
    this.axis.MinSliderButton().setXPos(mouseX);
  }
  
  
}

void mouseDragged(){
  if (this.axis.minSliderButton.clicked() || this.axis.minSliderButton.clicked) {
    this.axis.minSliderButton.clicked = true;
    this.axis.minSliderButton.drag(mouseX);
    this.axis.playWidget.x_pos = this.axis.minSliderButton.x_pos;
    this.axis.playWidget.display = false;
    this.axis.resetCaseWaving();
    this.axis.playButton.play = false;
  }
}

void mouseReleased(){
  if (this.axis.playButton.clicked() || this.axis.clicked() ||
      this.axis.minSliderButton.clicked() || this.axis.minSliderButton.getClicked()) {
     listen(); 
  }
  this.axis.minSliderButton.clicked = false;
}

void listen() {
  eventDispatcher.register(map, PanMapEvent.TYPE_PAN, map.getId());
  eventDispatcher.register(map, ZoomMapEvent.TYPE_ZOOM, map.getId());
}

void mute() {
    eventDispatcher.unregister(map, PanMapEvent.TYPE_PAN, map.getId());
    eventDispatcher.unregister(map, ZoomMapEvent.TYPE_ZOOM, map.getId());
}

public void mousePressed() {
  if (this.axis.playButton.clicked() || this.axis.clicked() || 
      this.axis.minSliderButton.clicked() || this.axis.minSliderButton.getClicked()) {
    mute(); 
   }
}