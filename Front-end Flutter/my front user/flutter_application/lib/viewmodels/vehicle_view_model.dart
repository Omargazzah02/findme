   


import 'package:flutter/material.dart';
import 'package:flutter_application/models/brand_register_model.dart';
import 'package:flutter_application/models/vehicle_model.dart';
import 'package:flutter_application/models/vehicle_register.model.dart';
import 'package:flutter_application/services/vehicle_service.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';

class VehicleViewModel extends ChangeNotifier  {
final VehicleService _vehicleService = VehicleService();

  Future <List<BrandRegisterModel>> getBrands () async {

     List<BrandRegisterModel> brands =  await _vehicleService.getBrands();
     return brands;
   
  }


  Future<List<VehicleRegisterModel>> getVehiclesByBrand (String id) async{
    return await _vehicleService.getVehiclesByBrand(id);

  }


  Future <VehicleModel?> getVehicle ( ) async {
     final AuthViewModel authViewModel = AuthViewModel();


    String? _token = await authViewModel.getToken();

    VehicleModel? vehicleModel =  await _vehicleService.getVehicle(_token);
    return vehicleModel;

  }




  Future <bool> updateVehicle (String? idVehicle ) async {
     final AuthViewModel authViewModel = AuthViewModel();


    String? _token = await authViewModel.getToken();

    bool result  = await _vehicleService.updateVehicle(_token, idVehicle);
    return result;

  }
}


   