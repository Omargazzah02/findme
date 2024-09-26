class PersonalInformationModel {

 String firstName;
 String lastName;
 String address;
String telephone;
String email;



 PersonalInformationModel({ required this.firstName , required this.lastName , required this.address , required this.telephone ,required this.email});




Map <String , dynamic> toJson() {
  return{
    
    "firstName":firstName,
    "lastName": lastName,
    "telephone"  : telephone,
    "address":address,
    "email" : email
   


  };
}



}