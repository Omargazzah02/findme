package com.my_back_v1.Dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class VehicleRequestDto {

    String brandId;
    String vehicleType;
    String variant ;
    String model;
    Integer releaseYear;
    double batteryCapacityKwh;
    double averageEnergyConsumptionKwhPerKm;
    double acChargerMaxPower;
    double dcChargerMaxPower;
    List<Integer> connectors = new ArrayList<>();




}
