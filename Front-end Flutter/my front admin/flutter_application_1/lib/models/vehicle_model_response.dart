
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/models/entity_model.dart';

class VehicleModelResponse {
  String id;
  String name;
  String brandId;
  String vehicleType;
  String variant;
  String model;
  int? releaseYear;
  double batteryCapacityKwh;
  double averageEnergyConsumptionKwhPerKm;
  double acChargerMaxPower;
  double dcChargerMaxPower;

  // Constructeur
  VehicleModelResponse({
    required this.id,
    required this.name,
    required this.brandId,
    required this.vehicleType,
    required this.variant,
    required this.model,
    required this.releaseYear,
    required this.batteryCapacityKwh,
    required this.averageEnergyConsumptionKwhPerKm,
    required this.acChargerMaxPower,
    required this.dcChargerMaxPower,
  });




    Entity toEntity() {
    return Entity(id: id, name: name);
  }




  // Factory method to create an instance from JSON
  factory VehicleModelResponse.fromJson(Map<String, dynamic> json) {
    return VehicleModelResponse(
      id: json['id'],
      name: json['name'],
      brandId: json['brandId'],
      vehicleType: json['vehicleType'], 
      variant: json['variant'] ,
      model: json['model'] ,
      releaseYear: json['releaseYear'] ,
      batteryCapacityKwh: json['batteryCapacityKwh'] ,
      averageEnergyConsumptionKwhPerKm: json['averageEnergyConsumptionKwhPerKm'] ,
      acChargerMaxPower: json['acChargerMaxPower'] ,
      dcChargerMaxPower: json['dcChargerMaxPower']
  );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brandId': brandId,
      'vehicleType': vehicleType,
      'variant': variant,
      'model': model,
      'releaseYear': releaseYear,
      'batteryCapacityKwh': batteryCapacityKwh,
      'averageEnergyConsumptionKwhPerKm': averageEnergyConsumptionKwhPerKm,
      'acChargerMaxPower': acChargerMaxPower,
      'dcChargerMaxPower': dcChargerMaxPower,
    };
  }










    static List<Entity> toEntityList(List<VehicleModelResponse> vehiclesModelResponse) {

          return vehiclesModelResponse.map((vehicleModelResponse) => vehicleModelResponse.toEntity()).toList();

    
     

   }





     DropdownItem toDropdownItem () {
    return DropdownItem(value: id, text: name);
  }












}
