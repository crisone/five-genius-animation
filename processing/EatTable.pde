class EatTable {
    float posX;
    float posY;
    float tableRadius;

    float []chopAngles;
    float []chopTargetAngles;
    float []chopOriginAngles;

    int [] ideaCounts;

    int chopsticCount;

  EatTable(float x, float y, float radius) {
    posX = x;
    posY = y;
    tableRadius = radius;
    chopAngles = new float[5];
    chopTargetAngles = new float[5];
    chopOriginAngles = new float[5];
    ideaCounts = new int[5];
    for(int i =0; i < 5; i++) {
      chopAngles[i] = i * (2 * PI)/5 + (3 * PI / 10);
      chopTargetAngles[i] = chopAngles[i];
      chopOriginAngles[i] = chopAngles[i];
    }
  }

  void setChopStatus(int chopIdx, int side) {
      chopTargetAngles[chopIdx] = chopOriginAngles[chopIdx] + side * (PI/5 - PI/60);
  }

  void takeChop(int seat, int side) {
    int chopNum;
    chopNum = seat + side;
    if(chopNum > 4) {
      chopNum = 0;
    }
    if(side > 0) {
      chopTargetAngles[chopNum] -= (PI/5 - PI/60);
    } else {
      chopTargetAngles[chopNum] += (PI/5 - PI/60);
    }
  }

  void putChop(int seat, int side) {
    int chopNum;
    chopNum = seat + side;
    if(chopNum > 4) {
      chopNum = 0;
    }
    if(side > 0) {
      chopTargetAngles[chopNum] += (PI/5 - PI/60);
    } else {
      chopTargetAngles[chopNum] -= (PI/5 - PI/60);
    }
  }

  void display() {
    fill(240, 240, 220);  
    ellipse(posX, posY, tableRadius, tableRadius);

    // draw and animate chops
    stroke(80, 10, 10);
    strokeWeight(2);
    for(int i = 0; i < 5; i++) {
      if(chopTargetAngles[i] - chopAngles[i] > PI/180) {
        chopAngles[i] += PI/180;
      } else if(chopTargetAngles[i] - chopAngles[i] < -PI/180) {
        chopAngles[i] -= PI/180;
      }

      line(
        posX + 100 * cos(chopAngles[i]), posY - 100 * sin(chopAngles[i]),
        posX + 150 * cos(chopAngles[i]), posY - 150 * sin(chopAngles[i])
        );
    }

    stroke(80);
  }
}