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
Table table;
FilterButton[] filterButtons;
import java.util.*;
Case[] cases;
Location usaLocation = new Location(39.50, -98.35);
float marker_rad = 5;

EventDispatcher eventDispatcher;

void setup(){
  //size(800,800,P2D);
  fullScreen(P2D);
  frameRate(30);
  map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
  map.zoomAndPanTo(usaLocation, 4);
  barscale = new BarScaleUI(this, map, 100, 700);
  //MapUtils.createDefaultEventDispatcher(this, map);
  filterButtons = new FilterButton[3];
  filterButtons[0] = new FilterButton("Age", 70, 100);
  filterButtons[1] = new FilterButton("Race", 70, 150);
  filterButtons[2] = new FilterButton("Gender", 70, 200);
  
  loadData();
  axis = new Axis(50,height-100,width-100);
  
  
  eventDispatcher = new EventDispatcher();
  MouseHandler mouseHandler = new MouseHandler(this, map);
  eventDispatcher.addBroadcaster(mouseHandler);
  listen();
  
}


void draw(){
  background(0);
  map.draw();
  barscale.draw();
  axis.draw();
  if(axis.playButton().getPlay()) {
    axis.sliderButton().drag(axis.sliderButton.getXPos()+axis.getDayUnit());
  }
  
  for(Case c:cases){
    //print(c.s_date);
    if(axis.getCurrentDate().equals(c.s_date)){
      ScreenPosition pos = map.getScreenPosition(c.location);
      c.display(pos);
    }
  }
  for(FilterButton fb: filterButtons){
    fb.display();
  }
}

void loadData(){
  
  table = loadTable("CleanMPVDataset.csv", "header");
  cases = new Case[table.getRowCount()];
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow r = table.getRow(i);
    cases[i] = new Case(r.getFloat("latitude"), r.getFloat("longitude"), r.getString("name"), r.getString("date"), r.getString("race"), r.getString("age"), r.getString("gender")); 
  }
  
  
}

void mouseMoved(){
 
}
void mouseClicked(){
  for(FilterButton fb: filterButtons){
    fb.onClicked(mouseX, mouseY);
  }
  for(Case c : cases){
    c.onClicked(mouseX, mouseY);
    c.popup.onClicked(mouseX, mouseY);
  }
  if (this.axis.playButton.clicked()) {
    this.axis.playButton.resetPlay();
  }
  else if (this.axis.clicked()) {
    this.axis.sliderButton().setXPos(mouseX);
  }
}

void mouseDragged(){
  if (this.axis.sliderButton.clicked() || this.axis.sliderButton.getClicked()) {
    this.axis.sliderButton.setClicked(true);
    this.axis.sliderButton.drag(mouseX);
  }
}

void mouseReleased(){
  if (this.axis.playButton.clicked() || this.axis.clicked() || this.axis.sliderButton.clicked() || this.axis.sliderButton.getClicked()) {
     listen(); 
  }
  this.axis.sliderButton.setClicked(false);
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
  if (this.axis.playButton.clicked() || this.axis.clicked() || this.axis.sliderButton.clicked() || this.axis.sliderButton.getClicked()) {
    mute(); 
   }
}