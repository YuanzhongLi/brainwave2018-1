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

int sleep_param = 0;

int sleep_seconds = 0;

int sleep_hours;

int sleep_minutes;

int await_count = 5;

String sleep_time;

boolean is_sleep;

void setup() {
  size(1200,800);
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

  if (buffer[0] <= 0.4) {
    sleep_param -= 1;
    if (sleep_param < 0) {
      sleep_param = 0;
    }
  } else {
    sleep_param += 1;
    if (sleep_param > 10) {
    sleep_param = 10;
    }
  }

  text("SLEEPING_PARAM : " + str(sleep_param), 50, 180);

  if (sleep_param > 6) {
    is_sleep = true;
  } else {
    is_sleep = false;
  }

  if (is_sleep) {
    await_count = 5;
    sleep_seconds += 1;
    if (sleep_seconds > 3600) {
      sleep_hours = floor(sleep_seconds/3600);
      sleep_minutes = floor((sleep_seconds - sleep_hours * 3600)/60);
      sleep_time = str(sleep_hours) + " hour " + str(sleep_minutes) + " min";
    } else if (sleep_seconds > 60) {
      sleep_minutes = floor(sleep_seconds/60);
      sleep_time = str(sleep_minutes) + " min " + str(sleep_seconds - 60 * sleep_minutes) + " sec";
    } else {
      sleep_time = str(sleep_seconds) + " sec";
    }
    text(sleep_time + " sleeping", 50, 80);
  } else if (!is_sleep && (await_count > 0)){
    if (sleep_seconds > 3600) {
      sleep_hours = floor(sleep_seconds/3600);
      sleep_minutes = floor((sleep_seconds - sleep_hours * 3600)/60);
      sleep_time = str(sleep_hours) + " hour " + str(sleep_minutes) + " min";
    } else if (sleep_seconds > 60) {
      sleep_minutes = floor(sleep_seconds/60);
      sleep_time = str(sleep_minutes) + " min " + str(sleep_seconds - 60 * sleep_minutes) + " sec";
    } else {
      sleep_time = str(sleep_seconds) + " sec";
    }
    text(sleep_time + " slept", 50, 80);
    text("After " + str(await_count) + " sec it will be closed", 50, 130);
    await_count -= 1;
  } else {
    text("Awake", 50, 80);
  }

  String wave_value = str(wave);
  text("ALPAH WAVE : " + wave_value, 50, 30);
}
