
import 'package:flutter_application_1/models/login_model.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel  {


final AuthService _authService = AuthService();

Future<bool> login (LoginModel loginModel) async {

final token = await _authService.loginAdmin(loginModel);


if (token != null ) {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("authToken" , token);
  return true;
  
}
else {
  return false ; 




}








}










Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 final  token = prefs.getString("authToken");
 return token; 
}




 Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    
  }



}