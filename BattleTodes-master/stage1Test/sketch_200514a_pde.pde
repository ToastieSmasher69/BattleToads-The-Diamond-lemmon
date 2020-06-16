class player { //<>//
  float x, xPos, y, w, h, lives, xSpeed, ySpeed;
  PImage img;
  player () {
    w=45;//ratio 3:4 (45:60)
    h=60;
    img=loadImage("playerStanding.png");
    img.resize(int(w), int(h));
    xPos=50;
    x = 50;
    y=flrLvl-h-1;
    lives=10;
    xSpeed = 0;
    ySpeed = 0;
  }
  void show() {
    fill(255, 84, 97);
    image(img, x, y);
  }
  void move() {
    if (x <= width-400) {
      x = x + xSpeed;
    } else {
      x = width -400;
    }
    xPos = xPos + xSpeed;

    if (y < flrLvl-h) {
      ySpeed = ySpeed + gravity;
    }
    y = y + ySpeed;
    if (y > flrLvl - h) {
      ySpeed = 0;
      y=flrLvl-h;
    }
  }
}

class enemy1 {
  float x, y, w, h, lives, xSpeed, ySpeed;
  PImage img;
  enemy1 () {
    w=30;
    h=40;
    x=width-50;
    y=flrLvl-h-1;
    lives=2;
    xSpeed = 0;
    ySpeed = 0;
    img=loadImage("characters.png");
    img.resize(int(w), int(h));
  }
}

class smallTree {
  float x, y, w, h ;
  PImage img;
  smallTree () {
    w=330; //ratio w to h is 3:4
    h=440;
    x=width-w;
    y=flrLvl-h;
    img=loadImage("smallTree.png");
    img.resize(int(w), int(h));
  }
  void show () {    
    //fill(255, 84, 97);
    image(img, x, y);
  }
  void move () {   //Tree's will move in according to players xSpeed
    x = x - player.xSpeed*0.9;
  }
}

class grass {
  float x, y, w, h;
  PImage img;
  grass () {
    w=width;
    h=40;
    x=0;
    y=flrLvl-h+7;
    img=loadImage("grass1.png");
    img.resize(int(w), int(h));
  }
  void show () {    
    //fill(255, 84, 97);
    image(img, x, y);
  }
}
smallTree [] smallTree;
enemy1 [] enemy1;
player player;
grass grass;

int flrLvl;
boolean gen = false;
final static float gravity = 0.5;
int temp1; //used for spawning tree in createBackground()

void createBackground() {
  background(0, 205, 255);
  fill(3, 150, 47); // green
  rect(0, flrLvl, width, height-flrLvl);
  if (gen == true) {
    temp1 = int(random(200));
    if (temp1 == 1) {
      smallTree = (smallTree[])append(smallTree, new smallTree());
    }
  }
  for (int i=0; i<smallTree.length; i++) {
    smallTree[i].move();
    smallTree[i].show();
  }
}

void setup() {
  fullScreen();
  noStroke();
  flrLvl = height-200;
  player = new player();
  grass = new grass();
  enemy1 = new enemy1[0];
  smallTree = new smallTree[0];
}

void draw() {
  createBackground();
  player.move();
  player.show();
  if (player.xSpeed == 5) {
    gen = true;
  }
  if (player.x >= player.xPos) {
    player.xPos = player.xPos + player.x;
  }
  print(player.xPos);
  grass.show();
}

void keyPressed() {
  if (key == 'W'||key =='w') {
    if (player.y == flrLvl-player.h) {
      player.ySpeed =-10;
    }
  }
  if (key == 'D'||key == 'd') {
    player.xSpeed = 5;
  }
  if (key == 'A'||key == 'a') {
    player.xSpeed = -5;
  }
}

void keyReleased() {
  if (key == 'D'||key== 'd'||key == 'A'||key == 'a') {
    player.xSpeed = 0;
    gen = false;
  }
}
