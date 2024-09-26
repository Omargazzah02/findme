
class UserRequestModel {
  String username;
  String email;
  String firstname;
  String lastname;
  String telephone;
  String address;
  String role;
  String? vehicleId;
  String? password ; 

  UserRequestModel({
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.telephone,
    required this.address,
    required this.role,
    required this.vehicleId,
    required this.password
  });

  // Convertit une instance de UserRequestModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'telephone': telephone,
      'address': address,
      'role': role,
      'vehicleId': vehicleId,
      'password' : password
    };
  }

  // Crée une instance de UserRequestModel à partir d'un JSON
  factory UserRequestModel.fromJson(Map<String, dynamic> json) {
    return UserRequestModel(
      username: json['username'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      telephone: json['telephone'],
      address: json['address'],
      role: json['role'],
      vehicleId: json['vehicleId'],
      password: json ["password"]
    );
  }
}
