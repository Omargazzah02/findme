import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_application_1/config.dart';
import 'package:flutter_application_1/models/brand_model.dart';
import 'package:flutter_application_1/models/connector_type_model.dart';
import 'package:flutter_application_1/models/entity_model.dart';
import 'package:flutter_application_1/models/user_request_model.dart';
import 'package:flutter_application_1/models/vehicle_model_response.dart';
import 'package:flutter_application_1/models/vehicle_request_model.dart';
import 'package:http/http.dart' as http;

class AdminService {
  final String url = "${Config.baseUrl}/admin_only";

  Future <List<BrandModel>?> getAllBrands (String? token ) async {

try {

      final response = await http.get(Uri.parse("$url/get-all-brands") ,
    headers:  {'Authorization' : 'Bearer $token' }

  
    ) ;

    if (response.statusCode == 200) {
      final List<dynamic> jsonData  = jsonDecode(response.body);
      return jsonData.map((json) => BrandModel.fromJson(json)).toList();







    }


    else {
      return null;
    }
}
catch (e) {
  print(e);
  return null ; 


}

  }
 



 Future <List<VehicleModelResponse>?> getAllByBrand (String? token , String brandId ) async {

try {

      final response = await http.get(Uri.parse("$url/get-vehicles-by-brand/$brandId") ,
    headers:  {'Authorization' : 'Bearer $token' }

  
    ) ;


    if (response.statusCode == 200) {
      final List<dynamic> jsonData  = jsonDecode(response.body);
      return jsonData.map((json) => VehicleModelResponse.fromJson(json)).toList();







    }


   
      return null;
   
}
catch (e) {
  print("erreur :$e");
  return null ; 


}





  }







 Future <List<VehicleModelResponse>?> getAllVehicles (String? token  ) async {

try {

      final response = await http.get(Uri.parse("$url/get-all-vehicles") ,
    headers:  {'Authorization' : 'Bearer $token' }

  
    ) ;

 

    if (response.statusCode == 200) {
      final List<dynamic> jsonData  = jsonDecode(response.body);


      return jsonData.map((json) => VehicleModelResponse.fromJson(json)).toList();







    }


   
      return null;
   
}
catch (e) {
  print("erreur :$e");
  return null ; 


}





  }



























  Future <List<ConnectorTypeModel>?> getAllConnectorTypes (String? token) async {

    try{

      
      final response = await http.get(Uri.parse("$url/get-connectortypes") ,
    headers:  {'Authorization' : 'Bearer $token' }

  
    ) ;


    if( response.statusCode == 200) {
     final List<dynamic> jsonData  = jsonDecode(response.body);
     return jsonData.map((json) => ConnectorTypeModel.fromJson(json)).toList();



    }

return null ; 


    }catch (e) {
        print("erreur :$e");



return null ; 



    }
   


  }





  Future <VehicleModelResponse?> getVehicleById (String? token , String id)  async {

    
    try{

      
      final response = await http.get(Uri.parse("$url/get-vehicle-by-id/$id") ,
    headers:  {'Authorization' : 'Bearer $token' }

  
    ) ;

    print("statut:${response.statusCode}");

    if( response.statusCode == 200) {
     
     return VehicleModelResponse.fromJson(jsonDecode(response.body));

      



    }

return null ; 


    }catch (e) {
        print("erreur :$e");



return null ; 



    }
   
  

  }
 









  Future <List<int>> getConnectorsByVehicle (String? token , String id)  async {

    
    try{

      
      final response = await http.get(Uri.parse("$url/get-connectors-by-vehicle/$id") ,
    headers:  {'Authorization' : 'Bearer $token' }

  
    ) ;



    if( response.statusCode == 200) {
     
      // Décode la réponse JSON
      final List<dynamic> jsonResponse = json.decode(response.body);

      // Extrait les valeurs de 'id' et les convertit en liste d'entiers
      final List<int> connectors = jsonResponse
          .map<int>((item) => (item as Map<String, dynamic>)['id'] as int)
          .toList();




          return connectors;

      



    }

return [] ; 


    }catch (e) {
        print("erreur :$e");



return [] ; 



    }
   
  

  }










  
  Future <BrandModel?> getBrandById (String? token , String id)  async {

    
    try{

      
      final response = await http.get(Uri.parse("$url/get-brand-by-id/$id") ,
    headers:  {'Authorization' : 'Bearer $token' }


  
    ) ;

   
    if( response.statusCode == 200) {
     
     return BrandModel.fromJson(jsonDecode(response.body));

      



    }

return null ; 


    }catch (e) {
        print("erreur :$e");



return null ; 



    }
   
  

  }







  Future <bool> addVehicle (String? token , VehicleRequestModel vehicleRequestModel) async {

try {
  final response = await http.post(Uri.parse("$url/add-vehicle") , 
       headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,
          body:  jsonEncode(vehicleRequestModel.toJson())

  
  );

  if (response.statusCode == 200)  {
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }
 




  Future <bool> updateVehicle (String? token , VehicleRequestModel vehicleRequestModel , String  idVehicle) async {

try {
  final response = await http.put(Uri.parse("$url/update-vehicle/$idVehicle") , 
       headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,
          body:  jsonEncode(vehicleRequestModel.toJson())

  
  );

  if (response.statusCode == 200)  {
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }
 





 

  Future <bool> deleteVehicle (String? token , String id ) async {

try {
  final response = await http.delete(Uri.parse("$url/delete-vehicle/$id") , 
       headers: {'Authorization' : 'Bearer $token'} ,
        

  
  );
  print(response.statusCode);

  if (response.statusCode == 200)  {
    
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }










  
  Future <bool> deleteUser (String? token , int id ) async {

try {
  final response = await http.delete(Uri.parse("$url/delete-user/$id") , 
       headers: {'Authorization' : 'Bearer $token'} ,
        

  
  );
  print(response.statusCode);

  if (response.statusCode == 200)  {
    
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }










  
  Future <bool> addBrand (String? token , String name  ) async {

try {
  final response = await http.post(Uri.parse("$url/add-brand") , 
       headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,

       body: jsonEncode({"name" : name})
        

  
  );

  print(response.statusCode);

  if (response.statusCode == 200)  {
    
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }
 






  Future <bool> updateBrand (String? token , String name , String id   ) async {

try {
  final response = await http.put(Uri.parse("$url/update-brand/$id") , 
       headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,

       body: jsonEncode({"name" : name})
        

  
  );
  
  print(response.statusCode);

  if (response.statusCode == 200)  {
    
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }
 








 

  Future <bool> deleteBrand (String? token , String id ) async {

try {
  final response = await http.delete(Uri.parse("$url/delete-brand/$id") , 
       headers: {'Authorization' : 'Bearer $token'} ,
        

  
  );
  print(response.statusCode);

  if (response.statusCode == 200)  {
    
    return true;
  }


    return  false ; 



}
catch(e) {


print("erreur $e");
return false ; 



}

  }






 Future <List<Entity>?> getAllUsers (String? token ) async {
  try{

      final response = await http.get(Uri.parse("$url/get-all-users") , 
       headers: {'Authorization' : 'Bearer $token'} ,
        

  
  );

  if (response.statusCode == 200) {
     final List<dynamic> jsonData  = jsonDecode(response.body);

     return jsonData.map((json) => Entity.fromJson(json)).toList();


  }
  else {

    
  return null ; 






  }










  }catch (e) {





    print("erreur : $e");
    return null ; 
  }
 }











 Future <List<Entity>?> getAllStations (String? token ) async {
  try{

      final response = await http.get(Uri.parse("$url/get-all-stations") , 
       headers: {'Authorization' : 'Bearer $token'} ,
        

  
  );

  if (response.statusCode == 200) {
     final List<dynamic> jsonData  = jsonDecode(response.body);

     return jsonData.map((json) => Entity.fromJson(json)).toList();


  }
  else {

    
  return null ; 






  }









  }catch (e) {





    print("erreur : $e");
    return null ; 
  }
 }

 



















 




 Future <int?> addUser(UserRequestModel userRequestModel , String? token) async {

  
try {
  final response = await http.post(Uri.parse("$url/add-user") , 
       headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,
          body:  jsonEncode(userRequestModel.toJson())

  
  );

 return response.statusCode;



}
catch(e) {


print("erreur $e");
return null ; 


}

 












 }
  





  
  Future <UserRequestModel?> getUserById (String? token , int id)  async {

    
    try{

      
      final response = await http.get(Uri.parse("$url/get-user/$id") ,
    headers:  {'Authorization' : 'Bearer $token'  }


  
    ) ;

    print(response.statusCode);

   
    if( response.statusCode == 200) {
     
     return UserRequestModel.fromJson(jsonDecode(response.body));

      



    }

return null ; 


    }catch (e) {
        print("erreur :$e");



return null ; 



    }
   
  

  }









 Future <int?> updateUser(UserRequestModel userRequestModel ,int id  ,  String? token) async {

  
try {
  final response = await http.put(Uri.parse("$url/update-user/$id") , 
       headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,
          body:  jsonEncode(userRequestModel.toJson())

  
  );

 return response.statusCode;



}
catch(e) {


print("erreur $e");
return null ; 


}

 












 }




}
