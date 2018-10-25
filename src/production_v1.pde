import oscP5.*;
import netP5.*;

final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

float[] buffer = new float[N_CHANNELS];

void oscEvent(OscMessage msg){
  float data;
  if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
    for(int ch = 0; ch < N_CHANNELS; ch++){
      data = msg.get(ch).floatValue();
      buffer[ch] = data;
    }
  }
}

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

  PFont font = createFont("MS Gothic",48,true);
  textFont(font);
  textSize(24);
  fill(255,0,0);

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

  String a_wave_value = str(wave);

  text(a_wave_value, 50, 30);

}
