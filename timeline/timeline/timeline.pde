import java.text.SimpleDateFormat;  
import java.util.Date;
import java.text.ParseException;
import java.util.Calendar;

Axis axis;

void setup() {
  size(1200, 1000, P2D);
  //frameRate(1);
  axis = new Axis(50,height-100,width-100);
}

void draw() {
  background(255,255,255);
  axis.draw();
  if(axis.playButton().getPlay()) {
    axis.sliderButton().drag(axis.sliderButton.getXPos()+axis.getDayUnit());
  }
}

void mouseDragged(){
  if (this.axis.sliderButton.clicked() || this.axis.sliderButton.getClicked()) {
    this.axis.sliderButton.setClicked(true);
    this.axis.sliderButton.drag(mouseX);
  }
}

void mouseClicked(){
  if (this.axis.playButton.clicked()) {
    this.axis.playButton.resetPlay();
  }
  else if (this.axis.clicked()) {
    this.axis.sliderButton().setXPos(mouseX);
  }
}

void mouseReleased(){
  this.axis.sliderButton.setClicked(false);
}