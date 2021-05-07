   #include "Wire.h"
#include "SPI.h"  // not used here, but needed to prevent a RTClib compile error
#include "RTClib.h"
#include "FirebaseESP8266.h"
#include <TridentTD_LineNotify.h>
#include <LiquidCrystal_I2C.h>
#include <SoftwareSerial.h>
#include "ThingSpeak.h"

#if defined(ESP8266)
#include <ESP8266WiFi.h>          //https://github.com/esp8266/Arduino
#else
#include <WiFi.h>          //https://github.com/esp8266/Arduino
#endif
#include <DNSServer.h>
#if defined(ESP8266)
#include <ESP8266WebServer.h>
#else
#include <WebServer.h>
#endif
#include <WiFiManager.h>
FirebaseData firebaseData;

RTC_DS3231 RTC;
LiquidCrystal_I2C lcd(0x27, 16, 2);
int data = 0;
int distance = 0;
#include <SoftwareSerial.h>
SoftwareSerial mySerial(D5, D2); // MRX, TX
//กำหนดขาของอุปกรณ์
const int pingPin = D0;
int inPin = D7;
#define D_Fertilizer_agitator D8 //เครื่องกวนปุ๋ย
#define D_water D6       //โซลินอยด์วาล์วระบบน้ำ//
#define D_Motor D10     //มอเตอร์//
#define D_Motor1 D9
// Config Firebase
#define FIREBASE_HOST "https://banana-2b8f2.firebaseio.com/"
#define FIREBASE_AUTH "CmdaAL0cg7MZ0BdtYS4MNgV8tlnAzsHmDtvupC9s"
// Config Thingeak
unsigned long myChannelNumber = 1082376;
const char * myWriteAPIKey = "2QVU67LMN9954N7N";
// Line config
#define LINE_TOKEN1 "tL0EDApus4aU9EPsNRQvwgKUSJ5mkLqCa0IU37ZyEcr"  //ความชื้นในดิน  
#define LINE_TOKEN2 "HEWcRtoPzB88AmLRBee8ycVzoctR09yGOm6pVOxQSNz"  // ปุ๋ยในดิน
#define LINE_TOKEN3 "1I2WG8dFvBWDpSKC6kp3qDsoKUx9H6lqACqHjt5E03W"  // ระดับน้ำในถัง
#define LINE_TOKEN4 "Fg0fArlfVyyZPLMEmAeSx2QxWNVzHplPgd79nEMEetG"  // ระดับปุ๋ยในถัง
WiFiClient  client;
DateTime now = RTC.now();
String i2cget;
String Distance = "", fertility = "", StringCut1, StringCut2, StringCut3, StringCut4, String1, String2, String3, String4;
int Mode = 1;
int Soil1, Distance1, Fertility1, tank1;//ค่าที่เซ็ต
int Soil, fertility2, Distance2, tank2;//ค่าเซนเซอร์
int Soil3, Fertility3, Distance3, tank3; //ค่าที่เซ็ต -10
int  T_minute;
int WaterPlant = 0;
int waterHour = 0;
int waterMin = 0;
int waitHour = 0;
int waitMin = 0;
void setup() {
  Serial.begin(115200);
  mySerial.begin(115200);
  WiFiManager wifiManager;
  wifiManager.autoConnect("Durian");
  lcd.begin();
  lcd.backlight();
  Wire.begin();
  RTC.begin();
  lcd.clear();
  WIFI_Setup();
  pinMode(D5, OUTPUT);
  pinMode(D2, INPUT);
  pinMode(D_water, OUTPUT);
  pinMode(D_Motor, OUTPUT);
  pinMode(D_Motor1, OUTPUT);
  pinMode(D_Fertilizer_agitator , OUTPUT);
  digitalWrite(D_water, HIGH);
  digitalWrite(D_Motor, HIGH);
  digitalWrite(D_Motor1, HIGH);
  digitalWrite(D_Fertilizer_agitator , HIGH);
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  RTC.adjust(DateTime(__DATE__, __TIME__));
  if (! RTC.isrunning()) {
    Serial.println("RTC is NOT running!");
    RTC.adjust(DateTime(__DATE__, __TIME__));
  }
  DateTime now = RTC.now();
}
void loop() {
  mySerialEvent();
  soilsensor();
  tank();
  doTime();
  Line();
  ThingSpeakcc();
  Firebasecc();
  Lcd();
  auto1();
  manual1();
   Set();
  
  delay(1000);
}
void Set(){
  Soil3= Soil1-20;
  Fertility3 =Fertility1-20;
  Distance3=Distance1-20;
  tank3=tank1-20;
}
void doTime() {
  DateTime now = RTC.now();
  Serial.print(now.hour(), DEC);
  Serial.print(':');
  Serial.print(now.minute(), DEC);
  Serial.print(':');
  Serial.println(now.second(), DEC);
  T_minute = int(now.minute());
}
void WIFI_Setup() {
  Serial.println("Connected: " + String(WiFi.SSID()));
  Serial.println("with Password: " + String(WiFi.psk()));
  Serial.println("IP " + WiFi.localIP().toString());

  ThingSpeak.begin(client);
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH); // Google Firebase
}
//############################################################################################//
void Delaywater() {
  Firebase.reconnectWiFi(true);
  Firebase.getInt(firebaseData, "water");
  data = firebaseData.intData();
  if (data == 0) {
    //    Serial.println("Device OFF");
    digitalWrite(D6, HIGH); //โซลินอยด์วาล์วระบบน้ำ//
    digitalWrite(D10, HIGH); //มอเตอร์//
    Serial.println("Delaywater OFF");
    Serial.println(" ");
  }
  else {
    //    Serial.println("Device ON");
    digitalWrite(D6, LOW); //โซลินอยด์วาล์วระบบน้ำ//
    delay(2000);
    digitalWrite(D10, LOW); //มอเตอร์//
    Serial.println("Delaywater ON");
    Serial.println(" ");
  }
}
//##########################################################################################//
void Delayfertilizer() {
  Firebase.reconnectWiFi(true);
  Firebase.getInt(firebaseData, "fertilizer");
  data = firebaseData.intData();

  if (data == 0) {
    //    Serial.println("Device OFF");
    digitalWrite(D8, HIGH); //เครืองกวน

    digitalWrite(D9, HIGH); //มอเตอร์
    Serial.println("Delayfertilizer OFF");
    Serial.println(" ");
  }
  else {
    //    Serial.println("Device ON");
    digitalWrite(D8, LOW); //เครื่องกวน
    delay(10000);
    digitalWrite(D9, LOW); // มาเตอร์
    Serial.println("Delayfertilizer ON");
    Serial.println(" ");
  }
}
//##########################################################################################//
void mySerialEvent() {
  while (mySerial.available()) {
    char inChar = (char)mySerial.read();
    //    Serial.println(inChar);
    if (inChar != '\r')
    {
      Distance += inChar;
      fertility += inChar;
    } else
    {
      US1();
      Npk_1();
    }
  }
}
void tank() {
  long duration, tank;
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(pingPin, LOW);
  pinMode(inPin, INPUT);
  duration = pulseIn(inPin, HIGH);
  tank = duration / 58.2;
  tank = 100 - tank;
  Serial.print("tank is:");
  Serial.print(tank);
  tank2 = tank;
  Serial.println("cm");
  delay(100);
}
void soilsensor() {
  int soilsensor = Serial.parseInt();
  const int analogInPin = A0;
  int sensorValue = 0;
  Soil = 0;
  sensorValue = analogRead(analogInPin);
  Soil = map(sensorValue, 870, 1023, 100, 0);
  Serial.print ("Soil Moisture : ");
  Serial.print(Soil);
  Serial.println(" %");

  delay(500);

}
void US1() {
  StringCut1 = Distance;
  StringCut2 = Distance;
  String1 = StringCut1.substring(1, 2);
  if (String1 == "d") {
    String2 = StringCut2.substring(2, StringCut2.length());
    Serial.println("mySerialEvent -> Distance = " + String2);
    Distance2 = String2.toInt();  //length

  }
  Distance = "";

}
void Npk_1() {
  StringCut3 = fertility;
  StringCut4 = fertility;
  String3 = StringCut3.substring(1, 2);
  //  Serial.println("String3 = f -> " + String3);
  if (String3 == "f") {
    String4 = StringCut4.substring(2, StringCut4.length() );
    Serial.println("mySerialEvent -> Fertility = " + String4);
    String4 = String4.toInt();  //length
    fertility2 = String4.toInt();
  }
  else {
  }
  fertility = "";
}

void auto1() {     //เปรียบเทียบค่าที่ได้รับมาจาก Firebase
  // data1 = Firebase.getInt("Mode");
  Firebase.reconnectWiFi(true);
  Firebase.getInt(firebaseData, "Mode");
  Mode = firebaseData.intData();
  if (Mode == 1 )
  {
    Serial.println("Mode Auto");
    //วัดปุ๋ย
    if ((fertility2 <= Fertility3) && (tank2 >= tank1 ) && ( Soil <= Soil3) && (Distance2 >= Distance1)) {
      int Hour = int(now.hour());
      int Min = int(now.minute());
      digitalWrite(D8, LOW ); //เปิดเครื่องกวนปุ๋ย
      digitalWrite(D9, LOW); //เปิดมอเตอร์//
      setTime(15, "water");
      digitalWrite(D8, HIGH ); //ปิดเครื่องกวนปุ๋ย
      digitalWrite(D6, LOW); //เปิดโซลินอยด์วาล์วระบบน้ำ//
      digitalWrite(D10, LOW); //เปิดมอเตอร์//
      
    }
    
    else if (tank2 <= tank3) {
      
      digitalWrite(D9, HIGH); //ปิดมอเตอร์//
    }
    // ให้น้ำ
    DateTime now = RTC.now();
    if (( Soil <= Soil3) && ( Distance2 >= Distance1 )) { //ตรวจสอบน้ำในแท๊ง
      int Hour = int(now.hour());
      int Min = int(now.minute());
      if (WaterPlant == 0) {
        digitalWrite(D6, LOW); //เปิดโซลินอยด์วาล์วระบบน้ำ//
        delay(2000);
        digitalWrite(D10, LOW); //เปิดมอเตอร์//
        Serial.print("รดน้ำเวลา "); Serial.print(Hour); Serial.print(" : "); Serial.println(Min);
        setTime(15, "water"); //ตั้งเวลารดน้ำ
        WaterPlant = 1;
        Serial.print("รดต่อถึงเวลา "); Serial.print(waterHour); Serial.print(" : "); Serial.println(waterMin);
      } else if (Hour == waterHour && Min == waterMin) {
        digitalWrite(D6, HIGH); //ปิดโซลินอยด์วาล์วระบบน้ำ
        digitalWrite(D10, HIGH); //ปิดมอเตอร์//
        Serial.println("ไม่รดแล้วนะ");
        setTime(30, "wait"); //ตั้งเวลาหยุด
      } else if (Hour == waitHour && Min == waitMin) {
        WaterPlant = 0;
        Serial.println("รดต่อละนะ");
      }
    } else if (( Soil >= Soil1) || ( Distance2 <= Distance3 )) {
      digitalWrite(D6, HIGH); //ปิดโซลินอยด์วาล์วระบบน้ำ//
      digitalWrite(D10, HIGH); //ปิดมอเตอร์//
      WaterPlant = 0;
      Serial.println("บังคับหยุดรดน้ำ");
    }
  }
}
void setTime(int waitTime, String command) {
  DateTime now = RTC.now();
  int Min = int(now.minute()) + waitTime;
  int Hour = int(now.hour());
  if (Min > 60) {
    Min -= 60;
    if (Hour == 23) Hour = 0;
    else Hour += 1;
  }
  if (command == "water") {
    waterHour = Hour;
    waterMin = Min;
  } else if (command == "wait") {
    waitHour = Hour;
    waitMin = Min;
  }
}
void manual1() {     //เปรียบเทียบค่าที่ได้รับมาจาก Firebase
  Firebase.reconnectWiFi(true);
  Firebase.getInt(firebaseData, "Mode");
  Mode = firebaseData.intData();
  if (Mode == 0 ) {
    Serial.println("Mode Manual");
    Serial.println(" ");
    Delayfertilizer();
    Delaywater();

  }
}
void Firebasecc() {
  Firebase.reconnectWiFi(true);
  Firebase.setInt(firebaseData, "sensor/Soil Moisture1", Soil);
  Soil = firebaseData.intData();

  Firebase.reconnectWiFi(true);
  Firebase.setInt(firebaseData, "sensor/Distance1", Distance2);
  Distance2 = firebaseData.intData();
  Firebase.reconnectWiFi(true);
  Firebase.setInt(firebaseData, "sensor/Fertility1", fertility2);
  fertility2 = firebaseData.intData();
  Firebase.reconnectWiFi(true);
  Firebase.setInt(firebaseData, "sensor/tank1", tank2);
  tank2 = firebaseData.intData();
  Firebase.getInt(firebaseData, "sensor/Soil Moisture");
  Soil1 = firebaseData.intData();
  Firebase.getInt(firebaseData, "sensor/Distance");
  Distance1 = firebaseData.intData();
  Firebase.getInt(firebaseData, "sensor/Fertility");
  Fertility1 = firebaseData.intData();
  Firebase.getInt(firebaseData, "sensor/tank");
  tank1 = firebaseData.intData();

}
void ThingSpeakcc() {
  ThingSpeak.setField(1, Soil);
  ThingSpeak.setField(2, fertility2);
  ThingSpeak.setField(3, Distance2);
  ThingSpeak.setField(4, tank2);
  // write to the ThingSpeak channel
  int x = ThingSpeak.writeFields(myChannelNumber, myWriteAPIKey);
  if (x == 200) {
    Serial.println("Channel update successful.");
  }
  else {
    Serial.println("Problem updating channel. HTTP error code " + String(x));
  }
}

void Line() {
  if (Soil <= Soil3)
  {
    LINE.setToken(LINE_TOKEN1);
    LINE.notify("ความชื้นในดินน้อย");
    LINE.notify(Soil);
  }

  if (fertility2 <= Fertility3)
  {
    LINE.setToken(LINE_TOKEN2);
    LINE.notify("ปุ๋ยในดินน้อย");
    LINE.notify(fertility2);
  }

  if (Distance2 <= Distance3)
  {
    LINE.setToken(LINE_TOKEN3);
    LINE.notify("น้ำในแท๊งค์ใกล้จะหมด");
    LINE.notify(Distance2);
  }
  if (tank2 <= tank3)
  {
    LINE.setToken(LINE_TOKEN4);
    LINE.notify("ปุ๋ยแท๊งค์ใกล้จะหมด");
    LINE.notify(tank2);
  }
}
void Lcd() {

  if (Mode == 1 ) {
    lcd.clear();
    lcd.setCursor(1, 0);
    lcd.print("Mode Auto");
    delay(250);
  }
  else {
    lcd.setCursor(1, 0);
    lcd.print("Mode man ");
    delay(250);
  }
  if (WiFi.status() != WL_CONNECTED ) {
    lcd.clear();
    lcd.setCursor(11, 0);
    lcd.print("WiFI OFF");
    delay(250);
  }
  else {
    lcd.setCursor(11, 0);
    lcd.print("WiFI ON ");
    delay(250);
  }
  //ความชื้นในดิน
  lcd.setCursor(0, 1);
  lcd.print("Soil ");
  lcd.setCursor(0, 2);
  lcd.print(Soil1);
  lcd.setCursor(20, 1);
  lcd.print(Soil);
  lcd.print(" ");
  //น้ำในถัง
  lcd.setCursor(5, 1);
  lcd.print("TW");
  lcd.setCursor(5, 2);
  lcd.print( Distance1);
  lcd.setCursor(25, 1);
  lcd.print(Distance2);
  lcd.print(" ");
  //ปุ๋ยในดิน
  lcd.setCursor(10, 1);
  lcd.print("Fer");
  lcd.setCursor(10, 2);
  lcd.print(Fertility1);
  lcd.setCursor(30, 1);
  lcd.print(fertility2);
  lcd.print(" ");
  //ปุ๋ยในถัง
  lcd.setCursor(15, 1);
  lcd.print("TF");
  lcd.setCursor(15, 2);
  lcd.print(tank1);
  lcd.setCursor(35, 1);
  lcd.print(tank2);
  lcd.print(" ");
}
