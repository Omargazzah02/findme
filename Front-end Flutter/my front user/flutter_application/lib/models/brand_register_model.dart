
class BrandRegisterModel {
  String id ;
  String name ; 
  
  BrandRegisterModel({required this.id, required this.name});
  


    factory BrandRegisterModel.fromJson(Map<String, dynamic> json) { 
      return BrandRegisterModel(id: json["id"]
      , name: json["name"]);
    }


}