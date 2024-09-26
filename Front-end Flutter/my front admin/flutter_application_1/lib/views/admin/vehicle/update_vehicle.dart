import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brand_model.dart';
import 'package:flutter_application_1/models/cable_model.dart';
import 'package:flutter_application_1/models/connector_type_model.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/models/vehicle_model_response.dart';
import 'package:flutter_application_1/models/vehicle_request_model.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/vehicle/chose_brand.dart';
import 'package:flutter_application_1/views/widgets/custom_delete_button.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_show_alert.dart';
import 'package:flutter_application_1/views/widgets/forms/admin/vehicle_form.dart';

// ignore: must_be_immutable
class UpdateVehicle extends StatefulWidget {
  final String id;
  UpdateVehicle({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateVehicleState createState() => _UpdateVehicleState();
}

class _UpdateVehicleState extends State<UpdateVehicle> {
  late AdminViewModel _adminViewModel;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _variantController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _releaseYearController = TextEditingController();
  TextEditingController _batteryCapacityKwh = TextEditingController();
  TextEditingController _averageEnergyConsumptionKwhPerKm = TextEditingController();
  TextEditingController _acChargerMaxPower = TextEditingController();
  TextEditingController _dcChargerMaxPower = TextEditingController();
  ValueNotifier<String?> _brandId = ValueNotifier<String?>(null);
  ValueNotifier<String?> _typeVehicle = ValueNotifier<String?>(null);
  bool loading = true ; 

  List<int> _selectedCableIds = [];
  List<DropdownItem> _brands = [];
  List<Cable> _cables = [];

  @override
  void initState() {
       _adminViewModel = AdminViewModel();
    initForm();
    super.initState();
 
  }

  Future<void> initForm() async {
    VehicleModelResponse? vehicleModelResponse = await _adminViewModel.getVehicleById(widget.id);

    if (vehicleModelResponse != null) {
      _selectedCableIds = await _adminViewModel.getConnectorsByVehicle(widget.id);


      List<BrandModel>? brands = await _adminViewModel.getAllBrands();
      List<ConnectorTypeModel>? connectorTypes = await _adminViewModel.getAllConnectorTypes();

if (mounted) {
        setState(() {
        _variantController.text =  vehicleModelResponse.variant;
        _modelController.text = vehicleModelResponse.model;
        _releaseYearController.text = vehicleModelResponse.releaseYear != null ?  vehicleModelResponse.releaseYear.toString() : "";
        _batteryCapacityKwh.text = vehicleModelResponse.batteryCapacityKwh.toString();
        _acChargerMaxPower.text = vehicleModelResponse.acChargerMaxPower.toString();
        _averageEnergyConsumptionKwhPerKm.text = vehicleModelResponse.averageEnergyConsumptionKwhPerKm.toString();
        _dcChargerMaxPower.text = vehicleModelResponse.dcChargerMaxPower.toString();
        _brandId.value = vehicleModelResponse.brandId;
        _typeVehicle.value = vehicleModelResponse.vehicleType;
        _brands = brands?.map((brand) => brand.toDropdownItem()).toList() ?? [];
        _cables = connectorTypes?.map((cable) => cable.toCable()).toList() ?? [];
         loading = false;
      });
}
      
    }

    
  }

  @override
  void dispose() {
    _variantController.dispose();
    _modelController.dispose();
    _releaseYearController.dispose();
    _batteryCapacityKwh.dispose();
    _averageEnergyConsumptionKwhPerKm.dispose();
    _acChargerMaxPower.dispose();
    _dcChargerMaxPower.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Véhicule")),
      body: loading ? Center(child:  CircularProgressIndicator(),) : 
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.directions_car, size: 70, color: AppColors.blue),
              VehicleForm(
                formKey: _formKey,
                variantController: _variantController,
                modelController: _modelController,
                releaseYearController: _releaseYearController,
                batteryCapacityKwh: _batteryCapacityKwh,
                averageEnergyConsumptionKwhPerKm: _averageEnergyConsumptionKwhPerKm,
                acChargerMaxPower: _acChargerMaxPower,
                dcChargerMaxPower: _dcChargerMaxPower,
                cables: _cables,
                brands: _brands,
                brandId: _brandId,
                vehicleType: _typeVehicle,
                selectedCableIds: _selectedCableIds,
              ),
              customDeleteButton(onPressed: () async {

                 bool result =  await _adminViewModel.deleteVehicle(widget.id);
                 if (result) {
                       Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ChoseBrands()),
);
    
                 }
                 else {
                  customShowAlert(context,"Une erreur est survenue lors de la tentative de suppression. Si ce véhicule est associé à un ou plusieurs utilisateurs, veuillez d'abord modifier les véhicules pour ces utilisateurs.");
                  
                 }
                


              }, context: context),
              customPostButton(onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                 bool result =  await _adminViewModel.updateVehicle(VehicleRequestModel(brandId:_brandId.value!, vehicleType: _typeVehicle.value!, variant: _variantController.text, model: _modelController.text, releaseYear: int.parse(_releaseYearController.text), batteryCapacityKwh: double.parse(_batteryCapacityKwh.text), averageEnergyConsumptionKwhPerKm: double.parse(_averageEnergyConsumptionKwhPerKm.text), acChargerMaxPower: double.parse(_acChargerMaxPower.text), dcChargerMaxPower: double.parse(_dcChargerMaxPower.text), connectors: _selectedCableIds), widget.id) ;
              if (result) {
             
                             Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ChoseBrands()),
);
    

              } else {
                          customShowAlert(context, "Erreur de connexion survenue");

              }
              
              
                }
            
              }, context: context, text: "Enregistrer"),
            ],
          ),
        ),
      ),
    );
  }
}
