import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cable_model.dart';
import 'package:flutter_application_1/models/connector_type_model.dart';
import 'package:flutter_application_1/models/vehicle_request_model.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/vehicle/chose_brand.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_show_alert.dart';
import 'package:flutter_application_1/views/widgets/forms/admin/vehicle_form.dart';

// ignore: must_be_immutable
class AddVehicle extends StatefulWidget {
    @override
  _AddVehicleState createState() => _AddVehicleState();
  String brandId;
  AddVehicle({required this.brandId});
}


class _AddVehicleState extends State <AddVehicle> {

  late AdminViewModel _adminViewModel;








    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _variantController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _releaseYearController = TextEditingController();
  TextEditingController _batteryCapacityKwhController = TextEditingController();
  TextEditingController _averageEnergyConsumptionKwhPerKmController = TextEditingController();
  TextEditingController _acChargerMaxPowerController = TextEditingController();
  TextEditingController _dcChargerMaxPowerController = TextEditingController();
  ValueNotifier<String?> _brandId = ValueNotifier<String?>(null);
  ValueNotifier<String?> _typeVehicle = ValueNotifier<String?>("car");
    List<int> _selectedCableIds = [];
  List<Cable> _cables = [];

  @override
  void initState() {

    _adminViewModel = AdminViewModel();
    initData();
    
    super.initState();
  }


Future <void >  initData  () async{

      List<ConnectorTypeModel>? connectorTypes = await _adminViewModel.getAllConnectorTypes();
      if(mounted) {
       setState(() {

                _cables = connectorTypes?.map((cable) => cable.toCable()).toList() ?? [];


         
       });
      }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Ajouter vehicule"),),

      body : SingleChildScrollView(child: Container(padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child:  Column(children: [
            VehicleForm(formKey: _formKey,  variantController: _variantController, modelController: _modelController, releaseYearController: _releaseYearController, batteryCapacityKwh: _batteryCapacityKwhController, averageEnergyConsumptionKwhPerKm: _averageEnergyConsumptionKwhPerKmController, acChargerMaxPower: _acChargerMaxPowerController, dcChargerMaxPower: _dcChargerMaxPowerController, cables: _cables, brands:[], brandId: _brandId, vehicleType: _typeVehicle, selectedCableIds: _selectedCableIds)
,           customPostButton(context: context , text: "Ajouter" , onPressed: () async {

               if (_formKey.currentState?.validate() ?? false) {
                 bool result = await _adminViewModel.addVehicle(VehicleRequestModel(brandId: widget.brandId, vehicleType: _typeVehicle.value, variant: _variantController.text, model: _modelController.text, releaseYear:int.parse(_releaseYearController.text), batteryCapacityKwh: double.parse(_batteryCapacityKwhController.text), averageEnergyConsumptionKwhPerKm: double.parse(_averageEnergyConsumptionKwhPerKmController.text), acChargerMaxPower: double.parse(_acChargerMaxPowerController.text), dcChargerMaxPower: double.parse(_dcChargerMaxPowerController.text), connectors: _selectedCableIds));
                 if (result) {
                
                Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ChoseBrands()),
);
                 }
                 else {
                  customShowAlert(context, "Erreur de connexion survenue");
                 }



               }

            })
          ],),))
      
    );

    
  }
  
}

