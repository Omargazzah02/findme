import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/models/user_request_model.dart';
import 'package:flutter_application_1/models/vehicle_model_response.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/user/show_users.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_show_alert.dart';
import 'package:flutter_application_1/views/widgets/forms/admin/user_form.dart';

class AddUser extends StatefulWidget {
    @override
  _StateAddUser createState() => _StateAddUser();

  

}
class _StateAddUser extends State<AddUser> {

      GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   late AdminViewModel _adminViewModel ;    
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
    List<DropdownItem> _vehicles = [ ];
   ValueNotifier<String?> _role = ValueNotifier<String?>("user");
      ValueNotifier<String?> _vehicleId = ValueNotifier<String?>(null);

      @override
  void initState() {

    _adminViewModel = AdminViewModel();
    initVehicles();
    
    super.initState();
  }


  Future <void > initVehicles () async  {

    List <VehicleModelResponse>? vehicles = await _adminViewModel.getAllVehicles();
    
    if (vehicles != null ) {
      if(mounted) {

     setState(() {
       
             _vehicles = vehicles.map((vehicle) => vehicle.toDropdownItem()).toList();

     });
      }
    }
    
    

  }
 






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Utilisateur"), backgroundColor: AppColors.orange,),
      body: SingleChildScrollView(child:
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(children: [
        UserForm(usernameController: _usernameController, emailController: _emailController, firstNameController: _firstNameController, lastNameController: _lastNameController, telephoneController: _telephoneController, addressController: _addressController, passwordController: _passwordController,vehicles: _vehicles, role: _role, vehicleId: _vehicleId , formKey: _formKey,),
      customPostButton(onPressed: () async {
        
 if (_formKey.currentState?.validate() ?? false)  {

  if (_role.value == "user" && _vehicleId.value == null ) {
    customShowAlert(context, "Veuillez saisir un véhicule.");

  } else   {

    int?  result  = await _adminViewModel.addUser(UserRequestModel(username: _usernameController.text, email: _emailController.text, firstname: _firstNameController.text, lastname: _lastNameController.text, telephone: _telephoneController.text, address: _addressController.text, password:_passwordController.text ,role: _role.value!, vehicleId:_vehicleId.value ));

       if (result == 200 ) {

        
                Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ShowUsers()),
);
              

       }
       else if (result ==409) {
        customShowAlert(context,"Utilisateur déjà existant !");
       }else {
              customShowAlert(context,"Erreur de connexion survenue");

       }


  }
  

 }






        


      }, context: context, text: "Ajouter") ],) ,
      )

      ),
    );





    
  }
  
}