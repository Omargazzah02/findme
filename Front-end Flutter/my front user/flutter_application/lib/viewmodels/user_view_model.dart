import 'package:flutter/material.dart';
import 'package:flutter_application/models/personal_information_model.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/services/user_service.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';

class UserViewModel extends ChangeNotifier {
    



  UserService _userService = new UserService();
  Future <UserModel?> userDetails ()  async {
      final AuthViewModel authViewModel = AuthViewModel();


    String? _token = await authViewModel.getToken();

     UserModel ?userModel =  await _userService.userDetails(_token);
    return userModel;

  }


  Future<bool>  updatePersonalInformation(PersonalInformationModel personalInformationModel) async {
     final AuthViewModel authViewModel = AuthViewModel();


    String? _token = await authViewModel.getToken();

    bool result = await _userService.updatePersonalInformation(_token, personalInformationModel);
    return result;
  }




  Future <bool> updatePassword(String password  )  async

  {

     final AuthViewModel authViewModel = AuthViewModel();


    String? _token = await authViewModel.getToken();

    bool result = await    _userService.updatePassword(password, _token);
    return result;
  }


 


}