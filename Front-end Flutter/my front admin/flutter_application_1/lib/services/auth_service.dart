import 'dart:convert';
import 'package:flutter_application_1/config.dart';
import 'package:flutter_application_1/models/login_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String url = Config.baseUrl;


  Future<String?> loginAdmin( LoginModel loginModel ) async {

    try {
      
    final response = await http.post(
      Uri.parse("$url/login/admin"),
      headers: {'Content-Type': 'application/json'},
      
      body: jsonEncode(loginModel.toJson()),
      
    
    )          .timeout(Duration(seconds:3)); // Timeout après 5 secondes

    print(response.body);

 


    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['token'];


      
    } else {

      return null;
    }
  }catch(e) {
        print("erreur $e");

    return null;
   
  }
  } 



}
