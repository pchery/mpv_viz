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

BarScaleUI barscale;
JSONArray c; 
Table table;
FilterButton[] filterButtons;
import java.util.*;
Case[] cases;
Location usaLocation = new Location(39.50, -98.35);
float marker_rad = 5;

void setup(){
  //size(800,800,P2D);
  fullScreen(P2D);
  map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
  map.zoomAndPanTo(usaLocation, 4);
  barscale = new BarScaleUI(this, map, 100, 700);
  MapUtils.createDefaultEventDispatcher(this, map);
  filterButtons = new FilterButton[1];
  filterButtons[0] = new FilterButton("Age", 100, 100);
  loadData();
}


void draw(){
  background(0);
  map.draw();
  barscale.draw();
  
  for(Case c:cases){
    ScreenPosition pos = map.getScreenPosition(c.location);
    fill(255,100,100);
    ellipse(pos.x, pos.y, marker_rad, marker_rad);
  }
  for(FilterButton fb: filterButtons){
    fb.display();
  }
}

void loadData(){
  
  table = loadTable("CleanMPVDataset1.csv", "header");
  cases = new Case[table.getRowCount()];
  for(int i = 0; i < table.getRowCount(); i++){
    TableRow r = table.getRow(i);
    cases[i] = new Case(r.getFloat("latitude"), r.getFloat("longitude")); 
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
  }
  
}