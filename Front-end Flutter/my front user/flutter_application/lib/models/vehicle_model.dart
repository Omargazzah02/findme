class VehicleModel  {

String name ; 
String vehicleType ; 
double batteryCapacityKwh;
double acChargerMaxPower;
double? dcChargerMaxPower;

VehicleModel ({required this.name , required this.vehicleType , required this.batteryCapacityKwh , required this.acChargerMaxPower , required this.dcChargerMaxPower});





    factory VehicleModel.fromJson(Map<String, dynamic> json) { 
      return VehicleModel
      (name : json["name"],
      vehicleType: json["vehicleType"],
      batteryCapacityKwh: json ["batteryCapacityKwh"],
      acChargerMaxPower: json ["acChargerMaxPower"],
      dcChargerMaxPower : json ["dcChargerMaxPower"]

    
      );
    }






}

