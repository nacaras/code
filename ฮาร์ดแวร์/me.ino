#include <LiquidCrystal_I2C.h>

#include <Wire.h>
#include <SoftwareSerial.h>
#define echoPin D6
#define trigPin D7
//SoftwareSerial NatSerial(2, 3); // RX, TX
LiquidCrystal_I2C lcd(0x27, 16, 2);
float data = 1.23f;

SoftwareSerial mySerial(2, 3); // RX, TX

void setup() {
  //pinMode(
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
//  pinMode(trigPin1, OUTPUT);
//  pinMode(echoPin1, INPUT);
  pinMode(2, INPUT);
  pinMode(3, OUTPUT);
  Serial.begin(115200);
  mySerial.begin(115200);


}

void loop() {
  mySerial.println("d" + String(distance()));
  delay(9000);
  mySerial.println("f" + String(Fertility()));
  delay(9000);
  
}
int distance() {  //ระดับน้ำในถัง
  int duration, distance;
  
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  //Serial.println(duration);
  distance = duration / 58.2;
  distance = 100 - distance;
  if (distance != 0) {
    Serial.print("Distance is :");
    Serial.print(distance);
    Serial.println("cm");
    return (distance);
    delay(500);
  }
}


float Fertility()
{
  float i, Fertility;
  Fertility = 0;
  for (i = 0; i < 20; i++) {
    Fertility = Fertility + analogRead(A0);
    delay(1);
  }
  Fertility = Fertility / 20;
  if (Fertility >= 620) {
    Fertility = ((Fertility - 620) / 9) + 93;
  } else if (Fertility >= 490) {
    Fertility = ((Fertility - 490) / 8) + 77;
  } else if (Fertility >= 360) {
    Fertility = ((Fertility - 360) / 8) + 59;
  } else if (Fertility >= 250) {
    Fertility = ((Fertility - 250) / 7) + 47;
  } else if (Fertility >= 170) {
    Fertility = ((Fertility - 170) / 5) + 31;
  } else if (Fertility >= 90) {
    Fertility = ((Fertility - 90) / 5) + 16;
  } else if (Fertility >=  10) {
    Fertility = ((Fertility - 10) / 5) + 0;
  }
  if (Fertility > 100) {
    Fertility = 100;
  }
  Serial.print("Fertility is : ");
  Serial.println(Fertility);
  return (Fertility);
  delay(500);
}
