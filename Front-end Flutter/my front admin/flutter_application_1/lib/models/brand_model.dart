import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/models/entity_model.dart';

class BrandModel {
  String id;
  String name;
  BrandModel({required this.id, required this.name});

  // Méthode pour convertir un BrandModel en Entity
  Entity toEntity() {
    return Entity(id: id, name: name);
  }


  Map <String , dynamic> toJson() {
  return{
  "id" : id,
  "name" : name 



  };
}



  DropdownItem toDropdownItem () {
    return DropdownItem(value: id, text: name);
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'],
      id: json['id'],
    );
}

    // Méthode statique pour convertir une liste de BrandModel en une liste d'Entity
  static List<Entity> toEntityList(List<BrandModel> brandModels) {

          return brandModels.map((brandModel) => brandModel.toEntity()).toList();

    
     

   }

}