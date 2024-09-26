class UserLoginRequestModel {
  String username; 
  String password;


  UserLoginRequestModel({required this.username , required this.password});




Map <String , dynamic> toJson() {
  return{
    "username":username,
    "password": password
  };
}



}