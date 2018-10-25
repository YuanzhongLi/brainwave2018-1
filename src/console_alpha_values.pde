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

void setup() {

  size(600,400);

  frameRate(1);

  PFont font = createFont("MS Gothic",48,true);
  textFont(font);
  textSize(24);
  fill(255, 255, 255);

  background(0);

  smooth();

}

void draw() {
  String wave_value0 = str(buffer[0]);
  String wave_value1 = str(buffer[1]);
  String wave_value2 = str(buffer[2]);
  String wave_value3 = str(buffer[3]);

  text(wave_value0, 50, 30);
  text(wave_value1, 50, 30);
  text(wave_value2, 50, 30);
  text(wave_value3, 50, 30);

}
