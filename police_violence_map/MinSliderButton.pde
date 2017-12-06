class MinSliderButton {
  
  float x_pos, y_pos, width_len, height_len;
  float MAX_X_POS;
  float MIN_X_POS;
  float current_pos;
  boolean clicked;
  Axis axis;
  
  MinSliderButton(Axis axis, float width_len, float height_len) {
    this.axis = axis;
    this.x_pos = axis.getXPos();
    this.MAX_X_POS = axis.getXPos() + axis.getLen();
    this.MIN_X_POS = axis.getXPos();
    this.y_pos = axis.getYPos()-10;
    this.width_len = width_len;
    this.height_len = height_len;
    this.current_pos = x_pos;
  }
  
  boolean getClicked() {
   return this.clicked; 
  }
  
  void setClicked(boolean bool) {
   this.clicked = bool; 
  }
  
  float getXPos() {
   return this.x_pos; 
  }
  
  void setXPos(float x_pos) {
   this.x_pos = x_pos; 
  }
  
  boolean clicked() {
    return ((mouseX>= this.x_pos && mouseX <= this.x_pos+width_len) && 
            (mouseY >= this.y_pos && mouseY <= this.y_pos+height_len));
  }
  
  void drag(float x_pos) {
    if(x_pos >= this.MIN_X_POS && x_pos <= this.axis.MaxSliderButton().getXPos()-20) {
      this.x_pos = x_pos;
    }
    else if(x_pos > this.axis.MaxSliderButton().getXPos()-20) {
      this.x_pos = this.axis.MaxSliderButton().getXPos()-20;
      if(this.axis.playButton().getPlay()) {
        this.axis.playButton().resetPlay();
      }
    }
    else {
      this.x_pos = this.MIN_X_POS;
    }
  }
  
  void draw() {
    fill(47,79,79);
    rect(x_pos, y_pos, width_len, height_len);
    textAlign(CENTER);
    fill(0);
    text(this.axis.formatXPosToDate(x_pos), x_pos, y_pos+50);
  }
}