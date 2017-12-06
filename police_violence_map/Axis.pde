class Axis {
  
  float x_pos, y_pos, len;
  float time_unit, current_time;
  Calendar calendar = Calendar.getInstance();
  String s_date = "2013-01-01", e_date = "2018-01-01";
  Date start_date, end_date;
  float day_unit;
  long num_days = 1827;
  PlayButton playButton;
  MinSliderButton minSliderButton;
  PlayWidget playWidget;
  
  Axis(float x_pos, float y_pos, float len) {
   this.x_pos = x_pos;
   this.y_pos = y_pos;
   this.len = len;
   day_unit = len/this.num_days;
   try {
    this.start_date = new SimpleDateFormat("yyyy-MM-dd").parse(s_date);
    this.end_date = new SimpleDateFormat("yyyy-MM-dd").parse(e_date);
   }
   catch (ParseException ex) { print("Error converting strings to dates");}
   playButton = new PlayButton(this.x_pos-25, this.y_pos-10, 20);
   minSliderButton = new MinSliderButton(this, 8, 20);
   playWidget = new PlayWidget(this, 10);
  }
  
  PlayButton playButton() {
    return this.playButton;
  }
  
  
  MinSliderButton MinSliderButton() {
    return this.minSliderButton;
  }
  
  PlayWidget playWidget() {
    return this.playWidget;
  }
  
  String formatXPosToDate(float x_pos) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    int days_num = (int) Math.floor(x_pos/this.day_unit);
    this.calendar.setTimeInMillis(start_date.getTime());
    calendar.add(Calendar.DATE, days_num);
    return sdf.format(calendar.getTime());
  }
  
  boolean displayCase(Case c) {
    if (this.playWidget.display) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      long case_date = 0;
      long current_date = 0;
      long min_date = 0;
      try {
      case_date = sdf.parse(c.s_date).getTime();
      current_date = sdf.parse(formatXPosToDate(this.playWidget.getXPos())).getTime();
      min_date = sdf.parse(formatXPosToDate(this.minSliderButton.getXPos())).getTime();
      }
      catch (ParseException ex) { print("Error converting strings to dates");}
      return case_date >= min_date && case_date <= current_date;
    }
    else {
      String current_date = formatXPosToDate(this.minSliderButton.getXPos());
      return c.s_date.equals(current_date) && !Float.isNaN(c.latitude) && !Float.isNaN(c.latitude);
    }
  }
  
  void resetCaseWaving() {
    for (Case c : cases)
      c.wave_on = true;
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
            (mouseY >= this.y_pos-3 && mouseY <= this.y_pos+3));
  }
  
  void draw() {
   fill(255);
   float x_pad = 5;
   float y_pad = 5;
   rect(playButton.x_pos - x_pad, this.y_pos - playButton.width_len/2 - y_pad,this.x_pos+this.len + 2*x_pad, playButton.width_len + 2*y_pad);
   line(this.x_pos, this.y_pos, this.x_pos+this.len, this.y_pos);
   fill(119,136,153);
   this.playButton.draw();
   this.minSliderButton.draw();
   this.playWidget.draw();
   
  }
}