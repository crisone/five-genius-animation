
Genius[] geniusList;
EatTable eatTable; 
int geniusCount;
int gStatus;

JSONArray cmdArray;
int curCmdIdx;
int nextTime;
int startMilliSecond;
int countDown;

PFont ft;

void setup() {
  size(1280, 720);

  frameRate(60);
  background(255, 255, 255);
  geniusCount = 5;

  float[] offsetX = { 0, -237, -146, 146, 237};
  float[] offsetY = {-250, -77, 202, 202, -77};
  
  geniusList = new Genius[5];
  for(int i =0; i < geniusCount; i++) {
    geniusList[i] = new Genius(640 + offsetX[i], 360 + offsetY[i]);
  }

  gStatus = 0;

  eatTable = new EatTable(640, 360, 320);

  cmdArray = loadJSONArray("./input/happy.json");
  curCmdIdx = 0;
  startMilliSecond = millis();
  countDown = 3;

  ft = createFont("./assets/Herculanum.ttf", 45);
  textFont(ft);
  textAlign(CENTER, CENTER);
}

void draw() {
  // background(250, 255, 250);
  // background(30, 30, 50);
  background(250, 250, 230);

  for(int i = 0; i < geniusCount; i++) {
    geniusList[i].display();
  }

  eatTable.display();

  int passMillis = 1000 * frameCount / 60;
  countDown = 3 - int(frameCount/60);
  fill(80);
  if(countDown > 0) {
    text(countDown, 640, 360);
  } else {
    text("GO", 640, 360);
  }

  if(curCmdIdx < cmdArray.size()) {
    JSONObject cmd = cmdArray.getJSONObject(curCmdIdx); 
    int t = cmd.getInt("time");
    if(passMillis - 3000 > t) {
      curCmdIdx++;
      JSONArray aa = cmd.getJSONArray("gstatus");
      for(int i = 0; i < 5; i++) {
        int gs =  aa.getInt(i);
        geniusList[i].setStatus(gs);
      }
      JSONArray bb = cmd.getJSONArray("cstatus");
      for(int i = 0; i < 5; i++) {
        int cs =  bb.getInt(i);
        eatTable.setChopStatus(i, cs);
      }
    }
  }

  // saveFrame("frames/baozi-####.jpg");
}

void mousePressed() {
  // gStatus = (gStatus + 1)%4;
  gStatus++;
  //print("pressed !" + mouseX + ", "+ mouseY);
  for(int i = 0; i < geniusCount; i++) {
    if (geniusList[i].overMe(mouseX, mouseY)) {
      //print("over me!");
      geniusList[i].nextStatus();
      if(gStatus%2 == 0) {
        eatTable.putChop(i, 0);
      } else {
        eatTable.takeChop(i, 0);
      }
    }
  }
}