package com.my_back_v1.Exceptions.Handler;

import com.my_back_v1.Exceptions.*;
import com.my_back_v1.shared.ErrorMessage;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
public class AppExceptionHandler {
    @ExceptionHandler(BindException.class)
    public ResponseEntity<List> bindException(BindException ex) {

        List<String> errors = ex.getAllErrors().stream().map(
                DefaultMessageSourceResolvable::getDefaultMessage
        ).collect(Collectors.toList());
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);

    }

    @ExceptionHandler(value =  {EntityNotFoundException.class})
    public ResponseEntity<Object> entityNotFoundException(EntityNotFoundException ex) {
        ErrorMessage errorMessage = ErrorMessage.builder().message(ex.getMessage()).timestamp(new Date()).code(404).build();
        return  new ResponseEntity<>(errorMessage, HttpStatus.NOT_FOUND);
    }



    @ExceptionHandler(value =  {EntityAlreadyExistsException.class})
    public ResponseEntity<Object> entityNotFoundException(EntityAlreadyExistsException ex) {
        ErrorMessage errorMessage = ErrorMessage.builder().message(ex.getMessage()).timestamp(new Date()).code(409).build();
        return  new ResponseEntity<>(errorMessage, HttpStatus.CONFLICT);
    }


    @ExceptionHandler(value =  {InvalidBatteryLevelException.class})
    public ResponseEntity<Object> invalidBatteryLevelException(InvalidBatteryLevelException ex) {
        ErrorMessage errorMessage = ErrorMessage.builder().message(ex.getMessage()).timestamp(new Date()).code(400).build();
        return  new ResponseEntity<>(errorMessage, HttpStatus.BAD_REQUEST);
    }



    @ExceptionHandler(value =  {ReservationExistsException.class})
    public ResponseEntity<Object> reservationExistsException(ReservationExistsException ex) {
        ErrorMessage errorMessage = ErrorMessage.builder().message(ex.getMessage()).timestamp(new Date()).code(409).build();
        return  new ResponseEntity<>(errorMessage, HttpStatus.CONFLICT);
    }


    @ExceptionHandler(value =  {ReservationIsAlreadyCanceledException.class})
    public ResponseEntity<Object> reservationIsAlreadyCanceledException(ReservationIsAlreadyCanceledException ex) {
        ErrorMessage errorMessage = ErrorMessage.builder().message(ex.getMessage()).timestamp(new Date()).code(409).build();
        return  new ResponseEntity<>(errorMessage, HttpStatus.CONFLICT);
    }






}
