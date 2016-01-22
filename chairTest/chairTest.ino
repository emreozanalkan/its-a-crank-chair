#include <PINGSensor.h>

#define PING_SENSOR_PIN 2

int rightForce;
int leftForce;
int turningDistance;

PINGSensor pingSensor(PING_SENSOR_PIN);

int cmDistance;


void setup()
{
  delay(1000000000);
  Serial.begin(9600);
  rightForce = 0;
  leftForce = 0;
  turningDistance = 0;
  cmDistance = 0;
}

void loop()
{
  cmDistance = pingSensor.getCmDistance();
  
  turningDistance = analogRead(A0);
  
  rightForce = analogRead(A2);
  
  leftForce = analogRead(A5);
  
  Serial.print("PING: ");
  Serial.print(cmDistance);
  Serial.print(" - ");
  Serial.print("Sharp: ");
  Serial.print(turningDistance);
  Serial.print(" - ");
  Serial.print("Right: ");
  Serial.print(rightForce);
  Serial.print(" - ");
  Serial.print("Left: ");
  Serial.println(leftForce);
  
  delay(500);
}
