import 'dart:convert';
import 'package:flutter_application/config.dart';
import 'package:flutter_application/models/user_register_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/models/user_login_request_model.dart';

class AuthService {
    final String url = Config.baseUrl;

  Future<String?> login(UserLoginRequestModel userLoginRequestModel) async {

    try {
      
    final response = await http.post(
      Uri.parse("$url/login/user"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userLoginRequestModel.toJson()),
      

    )          .timeout(Duration(seconds:2)); // Timeout après 5 secondes



    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['token'];
      
    } else {

      return null;
    }
  }catch(e) {
    print(e);
   
  }
    return null;
  } 






  Future <int?> register(UserRegisterRequestModel userRegisterRequestModel) async {

    try {

 final response = await http.post(
      Uri.parse("$url/register/user"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userRegisterRequestModel.toJson()),
      

    )    
          .timeout(Duration(seconds:1)); 
                print(response.statusCode);


        return response.statusCode;
         

      


    
    }

    catch(e) {
     
      return 0;
    
    
    }

  }
}
