
import 'package:flutter_application_1/models/cable_model.dart';

class ConnectorTypeModel {
  final int id;
  final String name;

  ConnectorTypeModel({
    required this.id,
    required this.name,
  });

  // Convertit une instance de ConnectorTypeModel en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Convertit une Map (JSON) en une instance de ConnectorTypeModel
  factory ConnectorTypeModel.fromJson(Map<String, dynamic> json) {
    return ConnectorTypeModel(
      id: json['id'],
      name: json['name'] 
    );
  }




  Cable toCable () {
    return Cable(name: name, id: id);
    
  }
}
