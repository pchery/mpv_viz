class Axis {
  
  float x_pos, y_pos, len;
  float time_unit, current_time;
  Calendar calendar = Calendar.getInstance();
  String s_date = "01/01/2013", e_date = "01/01/2018";
  Date start_date, end_date;
  float day_unit;
  long num_days = 1827;
  PlayButton playButton;
  SliderButton sliderButton;
  
  Axis(float x_pos, float y_pos, float len) {
   try {
     start_date = new SimpleDateFormat("MM/dd/yyyy").parse(s_date);
     end_date = new SimpleDateFormat("MM/dd/yyyy").parse(s_date);
   }
   catch(ParseException ex) {}
   this.x_pos = x_pos;
   this.y_pos = y_pos;
   this.len = len;
   day_unit = len/this.num_days;
   try {
    this.start_date = new SimpleDateFormat("MM/dd/yyyy").parse(s_date);
    this.end_date = new SimpleDateFormat("MM/dd/yyyy").parse(e_date);
   }
   catch (ParseException ex) { print("Error converting strings to dates");}
   playButton = new PlayButton(this.x_pos-25, this.y_pos-10, 20);
   sliderButton = new SliderButton(this, 8, 20);
  }
  
  PlayButton playButton() {
    return this.playButton;
  }
  
  SliderButton sliderButton() {
    return this.sliderButton;
  }
  
  String getCurrentDate() {
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    int days_num = (int) Math.floor(this.sliderButton().getXPos()/this.day_unit);
    this.calendar.setTimeInMillis(start_date.getTime());
    calendar.add(Calendar.DATE, days_num);
    return sdf.format(calendar.getTime()); 
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
  
  float getDayUnit() {
    return this.day_unit;
  }
  
  boolean clicked() {
    return ((mouseX>= this.x_pos && mouseX <= this.x_pos+this.len) && 
            (mouseY >= this.y_pos-3 && mouseY <= this.y_pos+3) &&
            !this.sliderButton.clicked());
  }
  
  void draw() {
   fill(255);
   float x_pad = 5;
   float y_pad = 5;
   rect(playButton.x_pos - x_pad, this.y_pos - playButton.width_len/2 - y_pad,this.x_pos+this.len + 2*x_pad, playButton.width_len + 2*y_pad);
   line(this.x_pos, this.y_pos, this.x_pos+this.len, this.y_pos);
   fill(119,136,153);
   this.playButton.draw();
   this.sliderButton.draw();
   
  }
}