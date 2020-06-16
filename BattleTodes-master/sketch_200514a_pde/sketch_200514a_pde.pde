//                             Program Mainline
tree [] tree;
enemy [] enemy;
player player;
gem [] gem;
cloud [] cloud;

int flrLvl; //Constant Floor Level
//int score = 0;
float g = 5000; //The world x position of the firs diamond, will increase by 5000 every time a diamond is found.
float xmax=width-300; //Maximum distance the player has travelled in the world
float screenMax = width-400; //The furtherst acroos the screen the character model can go
boolean generate = false; //generate = tree, Enemy and Diamond generateration   punch = the character punches...
final static float gravity = 0.5;

void createBackground() {
  background(0, 205, 255);
  fill(3, 150, 47); // green
  rect(0, flrLvl, width, height-flrLvl);
  if (generate == true) {
    int temp1 = int(random(80));
    if (temp1 == 1) {
      tree = (tree[])append(tree, new tree());
    }
    int temp2 = int(random(100));
    if (temp2 == 1) {
      cloud = (cloud[])append(cloud, new cloud());
    }
  }
}

void diamonds() {
  if (xmax == g) {
    print("gem created");
    gem = (gem[])append(gem, new gem());
    g = g + 5000;
    println(gem[0].x);
  }
  for (int i = 0; i<gem.length; i++) {
    if (pointScore(player, gem[i]) == true) {  
      gem[i].touch = true;      
      println("scored");
      for (int j = 0; j<gem.length-1; j++) {
        gem[j].x = gem[j+1].x;
        gem[j].y = gem[j+1].y;
        gem[j].w = gem[j+1].w;
        gem[j].h = gem[j+1].h;
      }
      gem = (gem[])shorten(gem);
      player.score = player.score + 1;
    }
  }
  for (int i = 0; i<gem.length; i++) {
    if (gem[i].x <= -60) {                  //I couldnt put both if statements in one for loop as it would crash as soon as a gem was removed from an array
      println("missed one");
      for (int j = 0; j<gem.length-1; j++) {
        gem[j].x = gem[j+1].x;
        gem[j].y = gem[j+1].y;
        gem[j].w = gem[j+1].w;
        gem[j].h = gem[j+1].h;
      }
      gem = (gem[])shorten(gem);
    }
  }
}

boolean pointScore(player p, gem g) {
  if (dist(p.x, p.y, g.x, g.y)<p.w/2+g.w/2) {
    return true;
  } else return false;
}

void setup() {
  fullScreen();
  noStroke();
  flrLvl = height-200;
  player = new player();
  enemy = new enemy[0];
  tree = new tree[0];
  gem = new gem[0];
  cloud = new cloud [0];
  treeImg = loadImage("tree.png");
  treeImg.resize(330, 440);
  cloudImg = loadImage("cloud.png");
  cloudImg.resize(450, 180);
  gemImg = loadImage("gem.png");
  gemImg.resize(60, 60);
}

void draw() {
  createBackground();
  for (int i=0; i<tree.length; i++) {
    tree[i].move();
    tree[i].show();
    if (tree[i].x <= -width+320) {
      tree[i].x = tree[tree.length-1].x;
      tree[i].y = tree[tree.length-1].y;
      tree[i].w = tree[tree.length-1].w;
      tree[i].h = tree[tree.length-1].h;
      tree = (tree[])shorten(tree);
    }
  }

  player.move();
  player.show();
  diamonds();
  if (player.x >= screenMax && player.xSpeed>0) {
    player.xPos = player.xPos + player.xSpeed;           
    if (xmax<player.xPos) { //xmax is the float value for the furtherst the player has travelled into the world, xPos is the float value for the position they are currently at in the world
      xmax=player.xPos;
      generate = true;
    }
  }
  for (int i=0; i<gem.length; i++) {
    gem[i].move();
    gem[i].show();
    if (dist(player.y, player.x, gem[i].x, gem[i].y) == 0) {
      gem[i].touch = true;
      print("lol");
    }
  }
  for (int i=0; i<cloud.length; i++) {
    cloud[i].move();
    cloud[i].show();
    if (cloud[i].x <= -width+320) {
      cloud[i].x=cloud[cloud.length-1].x;
      cloud[i].y=cloud[cloud.length-1].y;
      cloud[i].w=cloud[cloud.length-1].w;
      cloud[i].h=cloud[cloud.length-1].h;
      shorten(cloud);
    }
  }

  enemies();

  textSize(50);
  fill(255, 255, 255);
  text("Score: "+player.score, 700, flrLvl+60);
  text(str(player.x)+", "+str(player.xPos)+", "+str(xmax), 100, 100);            //This line displays the players 3 different x values, if you want to see them just remove the //
}

void keyPressed() {
  if (key == 'W'||key =='w') {
    if (player.y == flrLvl-player.h) {
      player.ySpeed =-10;
    }
  }
  if (key == 'D'||key == 'd') {
    player.xSpeed = 5;
    player.faceBack = false;
  }
  if (key == 'A'||key == 'a') {
    if (player.x < 0) {
      player.xSpeed = 0;
    } else {    
      player.xSpeed = -5;
    }
  }
  if (key == 'K'||key == 'k') {
    player.punch = true;
  }
}

void keyReleased() {
  if (key == 'D'||key == 'd'||key == 'A'||key == 'a') {
    generate = false;
    player.xSpeed = 0;
  }
  if (key == 'A'||key == 'a') {
    player.faceBack = true;
  }
  if (key == 'K'||key == 'k') {
    player.punch = false;
    println("yeet");
  }
}
