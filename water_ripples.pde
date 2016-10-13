import ddf.minim.*;

Minim minim;
AudioInput in;
float volumeIn;
float d = 0;
float sa;
float easing = 0.1;

float center_x = 0;
float center_y = 0;

//float color_r = random(255);
float color_r = 50;
float color_g = random(255);
//float color_b = random(255);
float color_b = 255;

void setup() {
  //size(500, 500);
  fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
  
  center_x = random(width);
  center_y = random(height);
}

float[] ds = new float[1024];
float[] cxs = new float[1024];
float[] cys = new float[1024];
float[] rs = new float[1024];
float[] gs = new float[1024];
float[] bs = new float[1024];
int ds_length = 0;

float dd = 0;
float pre_d = 0;
float pre_dd = 0;

boolean isChangable = false;
int defaultLeapCount = 50;
int leapCount = defaultLeapCount;

void draw() {
  background(#000000);
  volumeIn = map(in.left.level(), 0, 0.05, 0, width);
  sa = volumeIn - d;
  if(abs(sa) > 0.5){
    d = d + sa * easing; 
  }
  
  dd = d - pre_d;
  
  if (dd * pre_dd < 0) {
    ds[ds_length] = d;
    cxs[ds_length] = center_x;
    cys[ds_length] = center_y;
    rs[ds_length] = color_r;
    gs[ds_length] = color_g;
    bs[ds_length] = color_b;
    ds_length += 1;
  }
  
  pre_d = d;
  pre_dd = dd;
  
  for(int i = 0; i < ds_length; i++) {
    noFill();
    stroke(rs[i], gs[i], bs[i]);
    strokeWeight(5);
    ellipse(cxs[i], cys[i], ds[i], ds[i]);
  }
  
  noFill();
  stroke(color_r, color_g, color_b);
  strokeWeight(5);
  ellipse(center_x, center_y, d, d);
  
  if (d < 200) {
    leapCount--;
    if (isChangable || leapCount < 0) {
      center_x = random(width);
      center_y = random(height);
      color_r = 25;
      color_g = random(255);
      color_b = 255;
      isChangable = false;
      leapCount = defaultLeapCount;
    }
  } else {
    isChangable = true;
  }
}
