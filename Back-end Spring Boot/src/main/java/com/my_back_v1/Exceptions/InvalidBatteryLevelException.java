package com.my_back_v1.Exceptions;

public class InvalidBatteryLevelException extends  RuntimeException{
    public InvalidBatteryLevelException(String message ) {
        super(message);
    }
}
