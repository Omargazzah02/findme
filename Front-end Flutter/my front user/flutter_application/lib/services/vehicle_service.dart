import 'dart:convert';

import 'package:flutter_application/config.dart';
import 'package:flutter_application/models/brand_register_model.dart';
import 'package:flutter_application/models/vehicle_model.dart';
import 'package:flutter_application/models/vehicle_register.model.dart';
import 'package:http/http.dart' as http;

class VehicleService {
 
    final String url = Config.baseUrl;
    

    Future <List<BrandRegisterModel>> getBrands () async {

      try {


      final response = await http.get(Uri.parse("$url/brand/getall"));
    if (response.statusCode == 200){
      final List<dynamic> jsonData  = jsonDecode(response.body);
      return jsonData.map((json) => BrandRegisterModel.fromJson(json)).toList();
       
    }
    else {
      return[];
    }



      } catch (e) {
                print(e);

        return [];


      }






            


    }




    Future <List<VehicleRegisterModel>> getVehiclesByBrand (String id) async {
      try{

              final response = await http.get(Uri.parse("$url/vehicle/getallbybrand/$id"));

           print(response.statusCode);
                  if (response.statusCode == 200){
                        final List<dynamic> jsonData  = jsonDecode(response.body);
      return jsonData.map((json) => VehicleRegisterModel.fromJson(json)).toList();

                  }
                  else {return [];}


      }
      catch(e){
        print(e);
        return [];
      }

    }





    Future<VehicleModel?> getVehicle(String? token) async {
      try {

        
     final response  = await http.get(Uri.parse("$url/vehicle/get")  ,
     headers: {'Authorization' : 'Bearer $token'} );
     

     
     print(response.statusCode);

      VehicleModel? vehicleModel = VehicleModel.fromJson(jsonDecode(response.body));


      return vehicleModel;
    }
     catch(e){
      
       return null ; 

     }
    

}


Future <bool> updateVehicle (String? token , String? idVehicle) async{
  try 
  {
   final response = await  http.put(Uri.parse("$url/vehicle/update"),
        headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} 
        , 
        body: jsonEncode({"id" : idVehicle}));
   print (response.statusCode);
       if (response.statusCode ==200) {
        return true;
       } else {
        return false ;
       }
 
 



  }

  
    catch (e) {
      return false ;
    }
}
}