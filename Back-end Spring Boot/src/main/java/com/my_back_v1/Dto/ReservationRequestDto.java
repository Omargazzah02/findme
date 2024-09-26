package com.my_back_v1.Dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReservationRequestDto {
// connectorId  , startTime , endTime

    private String connectorId;
    private String startTime;
    private String endTime;






}
