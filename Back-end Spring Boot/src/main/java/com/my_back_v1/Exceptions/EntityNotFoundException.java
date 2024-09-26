package com.my_back_v1.Exceptions;

public class EntityNotFoundException extends  RuntimeException{
    public EntityNotFoundException (String message) {
        super(message);
    }
}
