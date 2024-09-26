
class Entity {
  final String id;
  final String name;

  Entity({required this.id, required this.name});

    factory Entity.fromJson(Map<String, dynamic> json) {
      return Entity(id: json["id"].toString(), name: json["name"]);


    }


}