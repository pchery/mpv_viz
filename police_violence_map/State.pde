class State{
  
  JSONArray coordinates;
  PShape shape;
  boolean highlighted = false;
  ArrayList<PVector> edges = new ArrayList<PVector>();
  
 State(JSONArray coords){
   coordinates = coords;
   shape = createContour(coordinates);
 }
  
  
 void display(){
   shape.setFill(0);
   if(highlighted){
      shape.setFill(0);
    }else{
      shape.setFill(255);
    }
   shape(shape, 0,0);  
 }
  
  PShape createContour(JSONArray coords){
    PShape s = null;
    if(coords.size() == 1){
        s = createShape();
        s.beginShape();
      }
      //loop over polygons
      for(int j = 0; j < coords.size(); j++){
        JSONArray b = coords.getJSONArray(j); 
        if(coords.size() >1){
          s = createShape();
          s.beginShape();
        }
        //loop over arrays
        for(int k = 0; k < b.size(); k++){
          JSONArray d = b.getJSONArray(k);
          
          //loop over coordinates
          for(int l = 0; l < d.size(); l++){
            float x = width*(d.getJSONArray(l).getFloat(0) + 175)/120;
            float y = (height*(1 - (d.getJSONArray(l).getFloat(1)+ 105)/180))*(180/60);
            //float x = width*(d.getJSONArray(l).getFloat(0) + 180)/360;
            //float y = height*(1 - (d.getJSONArray(l).getFloat(1)+ 90)/180);
            s.vertex(x,y);
          }
          
        }
        if(coords.size() > 1){
          s.endShape();
        }
       
      }
      if(coords.size() == 1){
          s.endShape();
       }
    return s;
  }
  
  void checkRollover(float xpos, float ypos){
  //  if((xpos > x && xpos < x + w) && (ypos > y && ypos < y + h)){
  //    highlighted = true;
  //    fill(0);
      
  //  }else{
  //    highlighted = false; 
  //    noFill();
  //  }
      
  //}
  
    //for(int i = 0; i < shape.getVertexCount() - 1; i++){
    //  PVector v = PVector.sub(shape.getVertex(i + 1), shape.getVertex(i)); 
    //  edges.add(v);
    //}
    
}    
 
 boolean cursorIn(float xpos, float ypos){
   
    PVector ext = new PVector(width, ypos);
    PVector pos = new PVector(xpos, ypos);
    int count = 0;
    for(int j = 0; j < shape.getVertexCount() - 1; j++){     
      PVector curr = shape.getVertex(j); 
      PVector next = shape.getVertex(j+1);
      //print("curr = " + curr + ", next = " + next + "\n");
      if(intersect(curr, next, pos, ext)){
        if(orientation(curr, pos, next) == 0){
         return onSegment(curr, pos, next); 
        }
        count++;
      }
      
      
    }
    if(count%2 == 1){
      highlighted = true;
      shape.setFill(0);
      return true;
    }
    highlighted = false;
    shape.setFill(255);
    return false;
  }
  
  int orientation(PVector p, PVector q, PVector r){
    float px = p.array()[0];
    float py = p.array()[1];
    float qx = q.array()[0];
    float qy = q.array()[1];
    float rx = r.array()[0];
    float ry = r.array()[1];
    
    float val = (qy - py)*(rx-qx) - (ry-qy)*(qx-px);
    
    if(val == 0){
      return 0; 
    }else if (val > 0){
      return 1;
    }else{
      return 2;
    }
  }
  
  boolean intersect(PVector p1, PVector q1, PVector p2, PVector q2){
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);
    
    if(o1 != o2 && o3 != o4){
      return true; 
    }
    if(o1 == 0 && onSegment(p1, p2, q1)) return true;
    if(o2 == 0 && onSegment(p1,q2, q1)) return true;
    if(o3 == 0 && onSegment(p2,p1, q2)) return true;
    if(o4 == 0 && onSegment(p2, q1, q2)) return true;
    
    return false;
    
    
  }
  
  boolean onSegment(PVector p, PVector q, PVector r){
    float px = p.array()[0];
    float py = p.array()[1];
    float qx = q.array()[0];
    float qy = q.array()[1];
    float rx = r.array()[0];
    float ry = r.array()[1];
    
    if(qx <= max(px, rx) && qx >= min(px, rx) && qy <= max(py, ry) && qy >= min(py, ry)){
       return true;
    }
    return false;
    
  }
}