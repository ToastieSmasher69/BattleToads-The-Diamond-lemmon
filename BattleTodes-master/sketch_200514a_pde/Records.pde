//            This contains all classes except enemy because thats a lot of code and gets messy
class player {
  float x, xPos, y, w, h, lives, liveY, liveX, xSpeed, ySpeed;
  int score;
  boolean punch, faceBack = false;
  PImage[] playerImg;
  PImage[] heartImg;
  player () {
    score = 0;
    w = 45;    //width - height ratio 3:4 (45:60)
    h = 60;
    xPos = 50;
    x = 50;
    y = flrLvl-h-1;
    lives = 3;
    liveY = height-170;
    liveX = 100;
    xSpeed = 0;
    ySpeed = 0;
    playerImg = new PImage[12];
    for (int i = 0; i < playerImg.length; i++) {
      playerImg[i] = loadImage("player"+i+".png");
      playerImg[i].resize(int(w), int(h));
    }
    heartImg = new PImage[4];
    for (int i = 0; i < heartImg.length; i++) {
      heartImg[i] = loadImage("lives"+i+".png");
      heartImg[i].resize(int(500), int(135));
    }
  }
  void show() {
    if (player.xSpeed == 0 && punch == false && faceBack != true) {
      image(playerImg[8], x, y);
    }
    if (player.xSpeed == 0 && punch == false && faceBack == true) {
      image(playerImg[9], x+25, y);
    }
    if (player.xSpeed > 0 && punch == false) {
      image(playerImg[int(frameCount/10)%4], x, y);
    }
    if (player.xSpeed < 0 && punch == false) {
      image(playerImg[4+int(frameCount/10)%4], x, y);
    }
    if (punch == true) {
      if (player.xSpeed == 0 && faceBack != true || player.xSpeed > 0) {
        image(playerImg[10], x, y);
        playerImg[10].resize(70, 60);
      }
      if (player.xSpeed < 0) {
        image(playerImg[11], x-25, y); // sorry about all the if statements sir, tested as efficient as I could but this is what I could do to make all the images line up
        playerImg[11].resize(70, 60);
      }
      if (player.xSpeed == 0 && faceBack == true) {
        image(playerImg[11], x, y);
        playerImg[11].resize(70, 60);
      }
    }

    if (player.lives==3) {
      image(heartImg[0], liveX, liveY);
    }
    if (player.lives==2) {
      image(heartImg[1], liveX, liveY);
    }
    if (player.lives==1) {
      image(heartImg[2], liveX, liveY);
    }    
    if (player.lives==0) {
      image(heartImg[3], liveX, liveY);
    }
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
    if (x < 0) {
      player.xSpeed = 0;
    }
  }
}

PImage treeImg; //only loads image once in setup rather than draw, thanks for the tip sir :D
class tree {
  float x, y, w, h ;
  PImage img;
  tree () {
    w=330; //ratio w to h is 3:4
    h=440;
    x=width+10;
    y=flrLvl-h;
    img=treeImg;
  }
  void show () {    
    image(img, x, y);
  }
  void move () {   //Tree's will move in according to players xSpeed
    x = x - player.xSpeed*0.9;
  }
}

PImage cloudImg; 
class cloud {
  float x, y, w, h;
  PImage img;
  cloud () {
    w=450;
    h=180;
    x=width+10;
    y=50;
    img = cloudImg;
  }
  void show () {    
    image(img, x, y);
  }
  void move () {   //Clouds will move in according to players xSpeed
    x = x - player.xSpeed;
  }
}

PImage gemImg;
class gem {
  float x, y, w, h;
  PImage img;
  boolean touch;
  gem () {
    w=60;
    h=60;
    x=width+10;
    y=flrLvl-140;
    touch = false;
    img = gemImg;
  }
  void show () {
    if (touch == false) {
      image(img, x, y);
    }
  }
  void move () {   //Gems will move in according to players xSpeed
    x = x - player.xSpeed;
  }
}
