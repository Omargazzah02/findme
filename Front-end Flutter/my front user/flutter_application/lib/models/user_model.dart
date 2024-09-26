
class UserModel {
  int id;
String username;
 String email;
 String firstName;
 String lastName;
 String address;
String telephone;



 UserModel({required this.id,required this.username, required this.email, required this.firstName , required this.lastName , required this.address ,  required this.telephone });





  factory UserModel.fromJson(Map<String, dynamic> json) { 
      return UserModel(id: json["id"], 
      username: json["username"],
      email: json ["email"],
      firstName:json["firstName"],
      lastName: json ["lastName"],
      address:  json ["address"],
      telephone:json["telephone"]
      
      
      
 );
    
    }










}


