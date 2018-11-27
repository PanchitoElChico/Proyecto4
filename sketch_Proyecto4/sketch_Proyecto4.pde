import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import ddf.minim.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer son;

Capture video;
OpenCV opencv;
Quad c;

int le = 6,u, y;
float sec;

void setup() {
  size(640, 480,P3D);
  noSmooth();
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);    
  video.start();
  
  minim = new Minim(this);
  son = minim.loadFile("alo.mp3");
  son.loop();
  
  c = new Quad(int(random(127)),int(random(128,255))); 
  u = width/le;
  y = height/le; 
  sec = 0;
}

void draw() {
 
  
  c.display();
}

class Quad{
 color linea,back;
 R pto1,pto2;
 
 Quad(color linea_,color back_){
  linea = linea_; back = back_;
  pto1 = new R(4);
  pto2 = new R(4);
 }
 void display(){
    scale(2);
  opencv.loadImage(video);
  sec += 0.02;
  for (int i = 0; i < video.width; i+=le) {
    for (int j = 0; j < video.height; j+=le) {

      pushMatrix();
       translate(i,j);
       rotate((2 * PI * brightness(int(i+j)) / 255.0));
       
       rectMode(CENTER);
       noStroke();
       
       switch(key){
        case '1': fill(video.pixels[i+j*video.width]+int(sec*200)); break;
        case '2': fill(video.pixels[i+j*video.width]-int(sec*200)); break;
        case '3': fill(video.pixels[i+j*video.width]*-8); break;
        case '4': fill(video.pixels[i+j*video.width]/180); break;
        default: fill(video.pixels[i+j*video.width]); break;
       }
       rect(0,0,sin(sec)*(le*(cos(sec)*20)),cos(sec)*(le*(sin(sec)*20)));
      popMatrix();
    }
  }
  
   fill(back,50);
   Rectangle[] faces = opencv.detect();
   
   /*for (int i = 0; i < faces.length; i++) {
    rectMode(CORNER);    
    pto1.playing(faces[i].x+(faces[i].width/2), faces[i].y+(faces[i].height/3), faces[i].width/2, faces[i].height/6); 
    pto2.playing(faces[i].x, faces[i].y+(faces[i].height/3), faces[i].width/2, faces[i].height/6);
    
  }
    println("Presiona 1, 2, 3 o 4 para cambiar de efecto"); 
 
}*/
}
}

class R{
 float intval;
 
 R(float innv){
  intval = innv;
 }
 
 void playing(float x,float y,float w,float h){
  for(float a = 0; a < w; a += intval){
   for(float b = 0; b < h; b += intval){
    fill(random(255));
    noStroke();
    rect(a+x,b+y,intval,intval);
   }
  }
 }
}

void captureEvent(Capture c) {
  c.read();
}