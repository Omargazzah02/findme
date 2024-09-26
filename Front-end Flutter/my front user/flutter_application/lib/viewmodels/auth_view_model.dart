
import 'package:flutter/material.dart';
import 'package:flutter_application/models/user_login_request_model.dart';
import 'package:flutter_application/models/user_register_request_model.dart';
import 'package:flutter_application/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {


final AuthService _authService = AuthService();

Future<bool> login (UserLoginRequestModel userLoginRequestModel) async {

final token = await _authService.login(userLoginRequestModel);


if (token != null ) {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("authToken" , token);
  notifyListeners();
  return true;
}
else {
  return false ; 
  

}



}




Future<int?> register (UserRegisterRequestModel userRegisterRequestModel) async {
final result = await _authService.register(userRegisterRequestModel);
return result;


}





Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 final  token = prefs.getString("authToken");
 return token; 
}




 Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    notifyListeners();
    
  }



}