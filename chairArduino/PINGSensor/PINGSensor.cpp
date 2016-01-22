//
//  PINGSensor.cpp
//  
//
//  Created by Emre Ozan Alkan on 10/14/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#include "PINGSensor.h"

PINGSensor::PINGSensor()
{
    _pin = -1;
    _timeOut = -1;
    _distance = 0;
}

PINGSensor::PINGSensor(int pin)
{
    _pin = pin;
    _timeOut = -1;
    _distance = 0;
}

PINGSensor::PINGSensor(int pin, int timeOut)
{
    _pin = pin;
    _timeOut = timeOut;
    _distance = 0;
}

PINGSensor::~PINGSensor()
{
    
}

void PINGSensor::triggerSensor()
{
    pinMode(_pin, OUTPUT);
    digitalWrite(_pin, LOW);
    delayMicroseconds(2);
    digitalWrite(_pin, HIGH);
    delayMicroseconds(5);
    digitalWrite(_pin, LOW);
}

void PINGSensor::readSensorData()
{
    triggerSensor();
    pinMode(_pin, INPUT);
    _distance = _timeOut > 0 ? pulseIn(_pin, HIGH, _timeOut) : pulseIn(_pin, HIGH); 
}

void PINGSensor::setDistance(int distance)
{
    _distance = distance;
}

int PINGSensor::getPin()
{
    return _pin;
}

void PINGSensor::setPin(int pin)
{
    _pin = pin;
}

int PINGSensor::getTimeOut()
{
    return _timeOut;
}

void PINGSensor::setTimeOut(int timeOut)
{
    _timeOut = timeOut;
}

int PINGSensor::getDistance()
{
    readSensorData();
    return _distance;
}

long PINGSensor::getInchDistance()
{
    return (((long)getDistance()) / ((long)74) / ((long)2));
}

long PINGSensor::getCmDistance()
{
    return (((long)getDistance()) / ((long)29) / ((long)2));
}


