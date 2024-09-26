import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/entity_model.dart';
import 'package:flutter_application_1/models/enum/route_enum.dart';
import 'package:flutter_application_1/views/admin/brand/update_brand.dart';
import 'package:flutter_application_1/views/admin/user/update_user.dart';
import 'package:flutter_application_1/views/admin/vehicle/update_vehicle.dart';
import 'package:flutter_application_1/views/widgets/animations/page_route_builder.dart';

class EntityListPage extends StatelessWidget {
  final List<Entity> entities;
  final MyRoute  page ;
  final IconData iconLeading;

  EntityListPage({
    required this.entities,
   required this.page,
    required this.iconLeading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: entities.length,
        itemBuilder: (context, index) {
          final entity = entities[index];
          return Card(
            child: ListTile(
              leading: Icon(iconLeading),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "ID : ${entity.id}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Nom : ${entity.name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed:() {

                   switch (page) {
       case MyRoute.vehicle:  Navigator.of(context).push(      animationCustomPageRoute(UpdateVehicle(id: entity.id)));
       case MyRoute.brand :   Navigator.of(context).push(      animationCustomPageRoute(UpdateBrand(id: entity.id)));
        case MyRoute.user :   Navigator.of(context).push(      animationCustomPageRoute(UpdateUser(id: int.parse(entity.id))));



       

       


      default:
        return ; // Retourne une page vide par défaut
    }

                  

                }
              ),
            ),
          );
        },
      ),
    );
  }
}
