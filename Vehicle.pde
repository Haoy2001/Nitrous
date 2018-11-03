class Vehicle {
  PVector pos;
  float vel = 0, acc = 0;
  float dir;
  float carWidth = 2.5;
  float carLength = 5.5;
  float carScale = 20;
  PShape carShape;
  PShape collider;
  
  Vehicle(float x, float y, PShape iCarShape) {
    pos = new PVector(x, y);
    carShape = iCarShape;
    collider = createShape(
      RECT,
      -carLength*carScale/2,
      -carWidth*carScale/2,
      carLength*carScale,
      carWidth*carScale
    );
    collider.setStroke(color(255));
    collider.setStrokeWeight(4);
    collider.setFill(color(127));
  }

  void update() {
    
    //collisions:
    collider.rotate(dir);
    shape(collider);
    
    float turningSpeed = 0.01;

    //left and right turns
    if (keyA) dir -= turningSpeed * vel * 0.65;
    if (keyD) dir += turningSpeed * vel * 0.65;

    //gas and break
    if (keyW) acc += 0.03;
    if (keyS) acc -= 0.06;

    //acceleration linear decay
    acc -= 0.01;
    //constraints on acceleration
    acc = constrain(acc, 0, 0.85);
    //velocity exponetial decay
    vel *= 0.9;

    vel += acc;
    if (vel < 0.01) vel = 0;

    pos.add(PVector.fromAngle(dir).mult(vel));
  }
}

class StarterCar extends Vehicle {
  StarterCar(float x, float y, PShape iCarShape) {
    super(x, y, iCarShape);
  }

  void display() {
    pushMatrix();
    {
      scale(carScale);
      rotate(HALF_PI + dir);
      rotateX(HALF_PI);
      rectMode(CENTER);
      fill(225, 128, 0);
      stroke(10);
      strokeWeight(1);
      shape(carShape, 0, 0);
    }
    popMatrix();
  }
}
