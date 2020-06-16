//            Everything associated with enemy - including class
int enemyGen = 1000; // Number will gradually increase in the void enemies() subprogram
class enemy {
  float x, y, w, h, lives, xSpeed, ySpeed;
  PImage[] img;
  enemy () {
    w=45;
    h=60;
    x=width+50;
    y=flrLvl-h-1;
    lives=2;
    xSpeed = 0;
    ySpeed = 0;
    img = new PImage[8];
    for (int i = 0; i < img.length; i++) {
      img[i] = loadImage("enemy"+i+".png");
      img[i].resize(int(w), int(h));
    }
    //img=loadImage("enemy0.png");
    //img.resize(int(w), int(h));
  }
  void show() {
    if (xSpeed >= 0) {
      image(img[int(frameCount/10)%4], x, y);
    } else {
      image(img[4+int(frameCount/10)%4], x, y);
    }
  }
  void move() {
    if (player.x - x < 0) {
      xSpeed = -3;
    }
    if (player.x - x > 0) {
      xSpeed = 3;
    }
    x = x + xSpeed;

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

void enemies() {
  if (xmax == enemyGen) {
    enemy = (enemy[])append(enemy, new enemy());
    enemyGen = enemyGen + 2000;
  }

  for (int i = 0; i<enemy.length; i++) {
    enemy[i].move();
    enemy[i].show();
    if (playerEnemy(player, enemy[i]) == true && player.punch == true) {
      for (int j = 0; j<enemy.length-1; j++) {
        enemy[j].x = enemy[j+1].x;
        enemy[j].y = enemy[j+1].y;
        enemy[j].w = enemy[j+1].w;
        enemy[j].h = enemy[j+1].h;
      }
      enemy = (enemy[])shorten(enemy);
    }
    //if (playerEnemy(player, enemy[i]) == true && player.punch == false && player.lives >= 0) {  //GET HELP FROM SIR
    //player.lives = player.lives - 1;
    //}
  }
}

boolean playerEnemy(player p, enemy e) {
  if (dist(p.x, p.y, e.x, e.y)<p.w/2+e.w/2) {
    return true;
  } else return false;
}
