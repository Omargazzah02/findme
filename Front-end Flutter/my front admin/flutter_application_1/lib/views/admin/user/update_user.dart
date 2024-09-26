import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/models/user_request_model.dart';
import 'package:flutter_application_1/models/vehicle_model_response.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/user/show_users.dart';
import 'package:flutter_application_1/views/widgets/custom_delete_button.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_show_alert.dart';
import 'package:flutter_application_1/views/widgets/forms/admin/user_form.dart';

// ignore: must_be_immutable
class UpdateUser extends StatefulWidget {
  int id ;
  UpdateUser({required this.id});
     @override
  _StateUpdateUser createState() => _StateUpdateUser();


}

class _StateUpdateUser extends State<UpdateUser> {

   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   late AdminViewModel _adminViewModel ;    
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
    List<DropdownItem> _vehicles = [ ];
   ValueNotifier<String?> _role = ValueNotifier<String?>(null);
      ValueNotifier<String?> _vehicleId = ValueNotifier<String?>(null);
      bool loading = false ; 



         @override
  void initState() {

    _adminViewModel = AdminViewModel();
    initVehicles();
    initForm();

    
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











  

  Future <void > initForm () async {
    
setState(() {
  loading=true;
});

       UserRequestModel? userRequestModel      = await _adminViewModel.getUserById(widget.id);


       if (userRequestModel != null ) {
  _usernameController.text = userRequestModel.username;
  _emailController.text = userRequestModel.email;
  _firstNameController.text=userRequestModel.firstname;
  _lastNameController.text = userRequestModel.lastname;
  _telephoneController.text=userRequestModel.telephone;
  _addressController.text=userRequestModel.address;
  _role.value = userRequestModel.role;
  _vehicleId.value = userRequestModel.vehicleId;



setState(() {
  loading = false;



});   


    }
     
  }
 








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:AppColors.orange , title: Text("Utilisateur"),),
      body: SingleChildScrollView(child: Form( 
        child: Container(width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
      
      child: loading ? Center(child: CircularProgressIndicator(),) : 
       Column(children: [
        UserForm(formKey: _formKey, usernameController: _usernameController, emailController: _emailController, firstNameController: _firstNameController, lastNameController: _lastNameController, telephoneController: _telephoneController, addressController: _addressController, passwordController: null, vehicles: _vehicles, role: _role, vehicleId: _vehicleId) ,
       
       
        customDeleteButton(onPressed: () async{
  bool  result = await    _adminViewModel.deleteUser(widget.id);

     if (result) {
                         Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ShowUsers()),
);


     } else {
                   customShowAlert(context, "Une erreur est survenue lors de la tentative de suppression. Si cette marque est associée à des véhicules, veuillez d'abord supprimer ces véhicules ou modifier leur marque avant de réessayer.");


     }

       }, context: context)
,
       customPostButton(onPressed: () async {
        

             
 if (_formKey.currentState?.validate() ?? false)  {

  if (_role.value == "user" && _vehicleId.value == null ) {
    customShowAlert(context, "Veuillez saisir un véhicule.");

  } else   {

    int?  result  = await _adminViewModel.updateUser(UserRequestModel(username: _usernameController.text, email: _emailController.text, firstname: _firstNameController.text, lastname: _lastNameController.text, telephone: _telephoneController.text, address: _addressController.text, password:null ,role: _role.value!, vehicleId:_vehicleId.value ,  ), widget.id );

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






        
        

       }, context: context, text: "Enregistrer")

       

      ])
      ))),
    );

       
  }
  
}