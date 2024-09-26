package com.my_back_v1.Dto;

import lombok.Data;

@Data

public class SearchStationsRequestDto {

    Integer currentBatteryLevel ;
    Integer desiredBatteryLevel ;
    double latitude;
    double longitude;
    boolean isCompatibleMeth =true;

    public boolean getIsCompatibleMeth() {
           return isCompatibleMeth;
       }
}
