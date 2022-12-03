// Class for animating a sequence of GIFs

class Genius {
  PImage[] images;

  int imageCount;
  int statusCount;
  int status;

  float xPos;
  float yPos;

  int frameAcc;
  int frame;

  PFont f;
  int ideas;

  Genius(float x, float y) {
    frameAcc = 0;
    imageCount = 4;
    statusCount = 4;
    status = 0;
    xPos = x - 100;
    yPos = y - 70;

    ideas = 0;

    images = new PImage[imageCount * statusCount];
    int idx = 0;
    for(int i = 0; i < statusCount; i++) {
      for(int j = 0; j < statusCount; j++) {
        String file_name = "./assets/" + nf(i, 1) + "_" + nf(j, 1) + ".png";
        images[idx] = loadImage(file_name);
        images[idx].resize(200,0);
        idx = idx + 1;
        //print(file_name);
      }
    }

      f = createFont("./assets/Herculanum.ttf", 45);
      textFont(f);
      textAlign(CENTER, RIGHT);
  }

  void setStatus(int s) {
    if(status==2 && s == 3) {
      ideas += 1;
    }
    status = s;
  }

  void nextStatus() {
    status = (status + 1)%statusCount;
  }

  boolean overMe(float x, float y) {
    //print("my pos: " + xPos + ", " + yPos);
    return (x > xPos) && (x < xPos + 200) && (y > yPos) && (y < yPos + 200);
  }

  void display() {
    frameAcc++;
    if(frameAcc > 8) {
      frameAcc = 0;
      frame = (frame+1) % imageCount;
    }
    image(images[status * imageCount + frame], xPos, yPos);

    fill(255, 204, 0);
    text(ideas, xPos + 150, yPos + 30);
  }
}