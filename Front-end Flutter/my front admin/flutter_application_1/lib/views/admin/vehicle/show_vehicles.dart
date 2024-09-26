import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/entity_model.dart';
import 'package:flutter_application_1/models/enum/route_enum.dart';
import 'package:flutter_application_1/models/vehicle_model_response.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/vehicle/add_vehicle.dart';
import 'package:flutter_application_1/views/widgets/entity_list_page.dart';

// ignore: must_be_immutable
class ShowVehicles extends StatefulWidget {
  
  @override
  _ShowVehiclesState createState() => _ShowVehiclesState();

  String id ; 
  ShowVehicles({required this.id});
}

class _ShowVehiclesState extends State<ShowVehicles> {
  late AdminViewModel _adminViewModel;
  List<Entity> _vehicles = [];
  bool _loading = true;
  bool _display = false;




  @override
  void initState() {
    _adminViewModel = AdminViewModel();
    _initVehicles();
    super.initState();
    
  }

  Future<void> _initVehicles() async {
    try {
      _loading=true ; 
      List<VehicleModelResponse>? vehicles  = await _adminViewModel.getAllVehiclesByBrand(widget.id);
      
      setState(() {
        if (vehicles != null) {
          _vehicles = vehicles.map((vehicle) => vehicle.toEntity()).toList();
          _display = true;
        } else {
          _display = false;
        }
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _display = false;
        _loading = false;
      });
      // Optionnel : loguer l'erreur ou afficher une notification
      print('Erreur de chargement des marques: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Véhicules'),
        backgroundColor: AppColors.orange,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator()) // Affiche un indicateur de chargement pendant le chargement des données
          : !_display
              ? Center(child: Text("Problème de connexion "))
              
               : Stack(children: [
                 _vehicles.isEmpty ? Center(child: Text("Aucune donnée disponible"),) : 

                    EntityListPage(
                  entities: _vehicles,
                  iconLeading: Icons.directions_car,
                  page:MyRoute.vehicle
                  
                    ),
                 
                Positioned(
            bottom: 20, // Ajuste cette valeur selon tes besoins
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {

                  
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddVehicle(brandId:widget.id,)),
            );
          
                  }, // Ne fait rien
                ),
              ),
            ),
                )

               ],)
    );
  }
}
