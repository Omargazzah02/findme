import 'package:flutter_application_1/models/brand_model.dart';
import 'package:flutter_application_1/models/connector_type_model.dart';
import 'package:flutter_application_1/models/entity_model.dart';
import 'package:flutter_application_1/models/user_request_model.dart';
import 'package:flutter_application_1/models/vehicle_model_response.dart';
import 'package:flutter_application_1/models/vehicle_request_model.dart';
import 'package:flutter_application_1/services/admin_service.dart';
import 'package:flutter_application_1/viewmodels/auth_view_model.dart';

class AdminViewModel {

   final AdminService _adminService = AdminService();
   final AuthViewModel _authViewModel = AuthViewModel();

   Future <List<BrandModel>?> getAllBrands() async{
       String? token = await _authViewModel.getToken();

    return await _adminService.getAllBrands(token);
  

   }




   
   Future <List<VehicleModelResponse>?> getAllVehiclesByBrand(String idBrand) async{
       String? token = await _authViewModel.getToken();

    return await  _adminService.getAllByBrand(token ,idBrand);
  

   }





   Future <List<ConnectorTypeModel>?> getAllConnectorTypes() async {
           String? token = await _authViewModel.getToken();
           return await _adminService.getAllConnectorTypes(token);


    

   }

   Future <VehicleModelResponse?> getVehicleById (String  id ) async {
               String? token = await _authViewModel.getToken();
               return await _adminService.getVehicleById(token, id);

    
   }





   Future <List<VehicleModelResponse>?> getAllVehicles ( ) async {
               String? token = await _authViewModel.getToken();
               return  await  _adminService.getAllVehicles(token);

    
   }



Future<List<int>> getConnectorsByVehicle (String id) async {
      String? token = await _authViewModel.getToken();
      return await  _adminService.getConnectorsByVehicle(token, id);

}




   Future <BrandModel?> getBrandById (String  id ) async {
               String? token = await _authViewModel.getToken();
               return  await _adminService.getBrandById(token, id);

    
   }

   Future <bool> addVehicle (VehicleRequestModel vehicleRequestModel) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.addVehicle(token, vehicleRequestModel);


   }

   
   Future <bool> updateVehicle (VehicleRequestModel vehicleRequestModel , String vehicleId) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.updateVehicle(token, vehicleRequestModel  ,vehicleId);


   }


   Future <bool> deleteVehicle (String id) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.deleteVehicle(token , id);


   }



   
   Future <bool> deleteUser (int id) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.deleteUser(token , id);


   }



   Future <bool> addBrand (String name ) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.addBrand(token , name);


   }



    Future <bool> updateBrand (String name , String id  ) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.updateBrand(token , name , id);


   }








Future <bool> deleteBrand (String id) async {
                   String? token = await _authViewModel.getToken();
                   return  await _adminService.deleteBrand(token , id);



   }





   Future <List<Entity>?> getAllUsers () async{
      String? token = await _authViewModel.getToken();
      return await _adminService.getAllUsers(token);

    
   }







   Future <List<Entity>?> getAllStations () async{
      String? token = await _authViewModel.getToken();
      return await _adminService.getAllStations(token);

    
   }






 
 Future <int?> addUser (UserRequestModel userRequestModel) async {
        String? token = await _authViewModel.getToken();
        return await _adminService.addUser(userRequestModel, token);

 }




 Future <UserRequestModel?> getUserById (int id  ) async {
        String? token = await _authViewModel.getToken();
        return await _adminService.getUserById(token, id);



 }


Future <int?> updateUser (UserRequestModel userRequestModel , int id) async {
        String? token = await _authViewModel.getToken();
        return await _adminService.updateUser(userRequestModel, id, token);

 }


}