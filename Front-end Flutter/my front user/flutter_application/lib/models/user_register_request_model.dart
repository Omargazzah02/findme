class UserRegisterRequestModel {
  
 String username;
 String email;
 String firstName;
 String lastName;
 String address;
 String password;
String vehiculeId;
String telephone;



 UserRegisterRequestModel({required this.username, required this.email, required this.firstName , required this.lastName , required this.address ,required this.password ,  required this.telephone ,required this.vehiculeId});




Map <String , dynamic> toJson() {
  return{
    "username":username,
    "email": email,
    "firstName":firstName,
    "lastName": lastName,
    "telephone"  : telephone,
    "address":address,
    "password":password,
    "vehiculeId":vehiculeId


  };
}






}