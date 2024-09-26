package com.my_back_v1.Exceptions;

public class ReservationIsAlreadyCanceledException extends  RuntimeException {
     public ReservationIsAlreadyCanceledException(String message) {
        super(message);
    }
}
