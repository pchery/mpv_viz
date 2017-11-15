class Axis {
   
  float x_pos, y_pos, len;
  float start_date, end_date, time_unit, current_time;
  PlayButton playButton;
  SliderButton sliderButton;
  
  Axis(float x_pos, float y_pos, float len) {
   this.x_pos = x_pos;
   this.y_pos = y_pos;
   this.len = len;
   playButton = new PlayButton(this.x_pos-25, this.y_pos-10, 20);
   sliderButton = new SliderButton(this, 8, 20);
  }
  
  PlayButton playButton() {
    return this.playButton;
  }
  
  SliderButton sliderButton() {
    return this.sliderButton;
  }
  
  float getXPos() {
   return this.x_pos; 
  }
  
  float getYPos() {
   return this.y_pos; 
  }
  
  float getLen() {
   return this.len; 
  }
  
  boolean clicked() {
    return ((mouseX>= this.x_pos && mouseX <= this.x_pos+this.len) && 
            (mouseY >= this.y_pos-3 && mouseY <= this.y_pos+3) &&
            !this.sliderButton.clicked());
  }
  
  void draw() {
   line(this.x_pos, this.y_pos, this.x_pos+this.len, this.y_pos);
   fill(119,136,153);
   this.playButton.draw();
   this.sliderButton.draw();
  }
}