class PlayWidget {
  
  float x_pos, y_pos, radius;
  float MAX_X_POS;
  float MIN_X_POS;
  float current_pos;
  boolean clicked, display=false;
  Axis axis;
  
  PlayWidget(Axis axis, float radius) {
    this.axis = axis;
    this.x_pos = axis.minSliderButton.x_pos;
    this.MAX_X_POS = axis.x_pos + axis.len;
    this.MIN_X_POS = axis.x_pos;
    this.y_pos = axis.y_pos;
    this.radius = radius;
    this.current_pos = x_pos;
  }
  
  
  boolean clicked() {
    return (Math.sqrt((mouseX-this.x_pos)*(mouseX-this.x_pos) + (mouseY-this.y_pos)*(mouseY-this.y_pos)) <= 3);
  }
  
  void drag(float x_pos) {
    if(x_pos >= this.MIN_X_POS && x_pos <= this.MAX_X_POS) {
      this.x_pos = x_pos;
    }
    else if (x_pos > this.MAX_X_POS) {
      this.x_pos = MAX_X_POS; 
    }
    else {
      this.x_pos = this.MIN_X_POS;
    }
  }
  
  void draw() {
    if(this.display) {
      fill(255,0,0);
      ellipse(x_pos, y_pos, radius, radius);
      stroke(255,0,0);
      line(this.axis.minSliderButton.x_pos, this.axis.minSliderButton.y_pos, this.x_pos, this.y_pos);
      stroke(0,0,0);
      textAlign(CENTER);
      fill(0);
      text(this.axis.formatXPosToDate(x_pos), x_pos, y_pos+30);
      if(this.x_pos == axis.x_pos+axis.len)
        axis.playButton.play = false;
    }
  }
}