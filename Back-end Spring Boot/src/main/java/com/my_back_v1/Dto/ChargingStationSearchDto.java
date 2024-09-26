package com.my_back_v1.Dto;

import com.my_back_v1.Models.ChargingStationEntity;
import lombok.Data;

import java.util.List;

@Data
public class ChargingStationSearchDto {

    String address;
    String postcode;
    double latitude;
    double longitude;

    Integer distanceKm;
    Integer remainingBatteryLevel ;
    String  duration;

    List<EquipmentSearchDTO> equipments;



}
