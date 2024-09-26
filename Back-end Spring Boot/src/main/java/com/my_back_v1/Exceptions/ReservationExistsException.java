package com.my_back_v1.Exceptions;

public class ReservationExistsException extends  RuntimeException{
    public ReservationExistsException(String  message) {
        super(message);
    }
}
