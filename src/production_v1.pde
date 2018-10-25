import oscP5.*;
import netP5.*;

final int N_CHANNELS = 4;

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

int white_rgb = 255;

int black_rgb = 0;

int BG_rgb;



void setup() {

  size(800,600);

  frameRate(1);

  if (buffer[0] > 0.4) {
    BG_rgb = black_rgb;
  } else {
    BG_rgb = white_rgb;
  }

  PFont font = createFont("MS Gothic",48,true);
  textFont(font);
  textSize(24);

  background(BG_rgb);

  smooth();

}

void draw() {

  if (buffer[0] <= 0.4) {
    BG_rgb += bright_rate;
    if (BG_rgb >= 255) {
      BG_rgb = 255;
    }
    background(BG_rgb);
  } else {
    BG_rgb -= bright_rate;

    if (BG_rgb <= 0) {
      BG_rgb = 0;
    }
    background(BG_rgb);
  }

  if (BG_rgb > 127.5) {
    fill(0, 0, 0);
  } else {
    fill (255, 255, 255);
  }

  String wave_value = str(buffer[0]);

  text(wave_value, 50, 30);

}
