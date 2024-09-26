import 'dart:convert';

import 'package:flutter_application/config.dart';
import 'package:flutter_application/models/personal_information_model.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:http/http.dart' as http;


class UserService {
    final String url = Config.baseUrl;

Future <UserModel?> userDetails (String? token ) async {

  try {

  final response = await http.get(Uri.parse("$url/user/user_details"),
  headers: {'Authorization' : 'Bearer $token'}

  
  );

  if (response.statusCode == 200) {

final  data = jsonDecode(response.body);
return UserModel.fromJson(data);
  }
  else {
    return null ; 
  }


} catch(e) {
  print(e);
  return null ; 


}  




}





Future<bool> updatePersonalInformation (String? token , PersonalInformationModel personalInformationModel) async{
  try {

    final response = await http.put(Uri.parse("$url/user/update/pi"),
      headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'},
      body:  jsonEncode(personalInformationModel.toJson())


    
    );

    if (response.statusCode==200) {
      return true;
    }
     else {return false ;
     
     }
 
  }catch(e) {
    
    print(e);
        return false ;


  }





}





Future<bool> updatePassword (String password , String? token )async{

  try {
  final response = await http.put(Uri.parse("$url/user/update/password"),
        headers: {'Authorization' : 'Bearer $token' , 'Content-Type': 'application/json'},
        body: jsonEncode({"password" : password})   
               );
print(response.statusCode);


               if (response.statusCode==200){return true;}
               else {
                return false ; 
               }

               

  }catch (e){
    print(e);
    return false 
    ;
  }



}















}
