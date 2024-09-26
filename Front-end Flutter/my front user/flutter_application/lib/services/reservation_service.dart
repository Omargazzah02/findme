import 'dart:convert';

import 'package:flutter_application/config.dart';
import 'package:flutter_application/models/reservation_request_model.dart';
import 'package:flutter_application/models/reservation_response_model.dart';
import 'package:http/http.dart' as http;
 
 class ReservationService{
    final String url = Config.baseUrl;

    Future<int?> addReservation (ReservationRequestModel reservationRequestModel , String? token )  async {
     
       try{
       final response = await http.post(Uri.parse("$url/reservation/add") ,
       
     headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'} ,
      body:  jsonEncode(reservationRequestModel.toJson())
       );


       return response.statusCode;












       }catch(e) {
        print(e);
        return null ;
       }









    }






    Future <List<ReservationResponseModel>? > getAllReservations (String? token) async {
   try {

       final response = await http.get(Uri.parse("$url/reservation/get") ,
         headers: {'Authorization' : 'Bearer $token'} 
      
       );

       print(response.statusCode);

       if (response.statusCode == 200) {
        final List<dynamic> jsonData  = jsonDecode(response.body);

      return jsonData.map((json) => ReservationResponseModel.fromJson(json)).toList();

       }


       return null ;

   }catch (e) {
print("erreur : $e");
return null; 

   }

    }






    


    Future <List<ReservationResponseModel>? > getReservationHistory (String? token) async {
   try {

       final response = await http.get(Uri.parse("$url/reservation/get-history") ,
         headers: {'Authorization' : 'Bearer $token'} 
      
       );

       print(response.statusCode);

       if (response.statusCode == 200) {
        final List<dynamic> jsonData  = jsonDecode(response.body);

      return jsonData.map((json) => ReservationResponseModel.fromJson(json)).toList();

       }


       return null ;

   }catch (e) {
print("erreur : $e");
return null; 

   }

    }












    Future <bool> cancelReservation (String? token , int reservationId ) async{
      try{
        final response = await http.delete(Uri.parse("$url/reservation/cancel/$reservationId" ),
          headers: {'Authorization' : 'Bearer $token'}
              
        
        );

        



        if (response.statusCode == 204 || response.statusCode==200 ) {
          
          return true ; 
        }

        return false ;










      } 
      
      
      
      
      
      
      
      
      catch(e) {
        print("erreur : $e");
        return false ; 

      }


    }




 }