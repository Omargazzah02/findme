

class VehicleRequestModel {
 
  String brandId;
  String ?vehicleType;
  String variant;
  String model;
  int? releaseYear;
  double batteryCapacityKwh;
  double averageEnergyConsumptionKwhPerKm;
  double acChargerMaxPower;
  double dcChargerMaxPower;
  List<int> connectors;

  // Constructeur
  VehicleRequestModel({
 
    required this.brandId,
    required this.vehicleType,
    required this.variant,
    required this.model,
    required this.releaseYear,
    required this.batteryCapacityKwh,
    required this.averageEnergyConsumptionKwhPerKm,
    required this.acChargerMaxPower,
    required this.dcChargerMaxPower,
    required this.connectors
  });









 
  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      
      'brandId': brandId,
      'vehicleType': vehicleType,
      'variant': variant,
      'model': model,
      'releaseYear': releaseYear,
      'batteryCapacityKwh': batteryCapacityKwh,
      'averageEnergyConsumptionKwhPerKm': averageEnergyConsumptionKwhPerKm,
      'acChargerMaxPower': acChargerMaxPower,
      'dcChargerMaxPower': dcChargerMaxPower,
      'connectors' : connectors


    };
  }


    


















}
