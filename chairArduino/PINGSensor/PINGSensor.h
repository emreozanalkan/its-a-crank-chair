//
//  PINGSensor.h
//  
//
//  Created by Emre Ozan Alkan on 10/14/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#ifndef PINGSensor_H
#define PINGSensor_H

#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

class PINGSensor
{
private:
    int _pin;
    int _timeOut;
    int _distance;
    
protected:
    PINGSensor();
    
    void setDistance(int distance);
    
    void triggerSensor();
    void readSensorData();
public:
    PINGSensor(int pin);
    PINGSensor(int pin, int timeOut);
    ~PINGSensor();
    
    int getPin();
    void setPin(int pin);
    
    int getTimeOut();
    void setTimeOut(int timeOut);
    
    int getDistance();
    long getInchDistance();
    long getCmDistance();
    
};

#endif  
