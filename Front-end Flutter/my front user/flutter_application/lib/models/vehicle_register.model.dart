class VehicleRegisterModel {
String id ;
String name ;


VehicleRegisterModel({
  required this.id,
  required this.name
});




    factory VehicleRegisterModel.fromJson(Map<String, dynamic> json) { 
      return VehicleRegisterModel
      (id: json["id"]
      , name: json["name"]);
    }



}