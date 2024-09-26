package com.my_back_v1.Dto;

import com.my_back_v1.Models.Status;
import lombok.Data;

@Data
public class ReservationResponseDto {
    private Integer idReservation;
    private String idConnector;
    private String connectorType;
    private String currentType;

    private String startTime;
    private String endTime;
    private String stationName ;
    private double latitude;
    private double longitude;
    private Status status; ;


}
