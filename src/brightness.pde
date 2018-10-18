int bright_rate = 26;

int white_rgb = 0;

int black_rgb =255;

int BG_rgb;

int wave = 20;

void setup() {
  
  size(600,400);
  
  frameRate(1);
  
  if (wave > 200) {
    BG_rgb = black_rgb;
  } else {
    BG_rgb = white_rgb;
  }
  
  background(BG_rgb);
  
  smooth();
  
}

void draw() {
  int s = second();
  
  if (s % 20 < 10) {
    wave = 20;
  } else {
    wave = 300;
  }
  
  
  if (wave < 200) {
    BG_rgb -= bright_rate;
    
    if (BG_rgb <= 0) {
      BG_rgb = 0;
    }
    
    background(BG_rgb);
    
  } else {
    
    BG_rgb += bright_rate;
    
    if (BG_rgb >= 255) {
      BG_rgb = 255;
    }
  
    background(BG_rgb);
  
  }
  
}
