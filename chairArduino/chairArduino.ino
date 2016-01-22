#include <PINGSensor.h>

#define PING_SENSOR_PIN 2

int rightForce;
int leftForce;
int turningDistance;

PINGSensor pingSensor(PING_SENSOR_PIN);

int cmDistance;

void setup()
{
  //delay(1000000000);
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
  
  rightForce = analogRead(A1);
  
  leftForce = analogRead(A2);
  
  
  if(turningDistance < 400)
  {
    Serial.print("#T!");
  }
  else if(rightForce >= 500 || leftForce >= 500)
  {
    Serial.print('#');
    if(rightForce > leftForce)
      Serial.print('R');
    else
      Serial.print('L');
    Serial.print(cmDistance);
    Serial.print('!');
  }
  else
  {
    Serial.print('#');
    if(cmDistance > 5 && cmDistance <= 15)
    {
      // sitting
      Serial.print('S');
    }
    else if(cmDistance <= 5)
    {
      // sitting backward
      Serial.print('B');
    }
    else if(cmDistance > 15 && cmDistance <= 30)
    {
      // sitting front
      Serial.print('F');
    }
    else if(cmDistance >= 300)
    {
      // 0.0f volume
      Serial.print(0);
    }
    else if(cmDistance >= 275)
    {
      // 0.1f volume
      Serial.print(1);
    }
    else if(cmDistance >= 250)
    {
      // 0.2f volume
      Serial.print(2);
    }
    else if(cmDistance >= 225)
    {
      // 0.3f volume
      Serial.print(3);
    }
    else if(cmDistance >= 200)
    {
      // 0.4f volume
      Serial.print(4);
    }
    else if(cmDistance >= 175)
    {
      // 0.5f volume
      Serial.print(5);
    }
    else if(cmDistance >= 150)
    {
      // 0.6f volume
      Serial.print(6);
    }
    else if(cmDistance >= 125)
    {
      // 0.7f volume
      Serial.print(7);
    }
    else if(cmDistance >= 100)
    {
      // 0.8f volume
      Serial.print(8);
    }
    else if(cmDistance > 75)
    {
      // 0.9f volume
      Serial.print(9);
    }
    else
    {
      // 1.0f volume
      Serial.print(10);
    }
    
    Serial.print('!');
  }
  
  delay(500);
}


