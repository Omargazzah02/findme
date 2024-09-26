package com.my_back_v1.Dto;

import lombok.Data;

@Data
public class VehicleResponseDto {
    String id ;
    String name ;
    String brandId;
    String vehicleType;
    String variant ;
    String model;
    Integer releaseYear;
    double batteryCapacityKwh;
    double averageEnergyConsumptionKwhPerKm;
    double acChargerMaxPower;
    double dcChargerMaxPower;



}

