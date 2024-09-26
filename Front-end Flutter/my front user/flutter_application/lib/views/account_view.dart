import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/personal_information_model.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/models/vehicle_model.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';
import 'package:flutter_application/viewmodels/user_view_model.dart';
import 'package:flutter_application/viewmodels/vehicle_view_model.dart';
import 'package:flutter_application/views/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();

}


class _AccountViewState extends State<AccountView> {
  late UserViewModel _userViewModel;
  late AuthViewModel _authViewModel;
     UserModel? _userModel;





  @override
  void initState() {
    super.initState();
      _userViewModel = Provider.of<UserViewModel>(context, listen: false);
        _authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    _fetchUserDetails();    super.didChangeDependencies();
    
  

  }



   





Future<void> _fetchUserDetails() async {
  final userModel = await _userViewModel.userDetails();
  if (mounted) { // Vérifie si le widget est toujours monté
    setState(() {
      _userModel = userModel;
    });
  }
}

  @override
  Widget build(BuildContext context) {
double  widthSize = MediaQuery.of(context).size.width;


 Widget _buildInkwel (
  {required name , required route ,  required IconData  icon } ) {





return             InkWell(
              onTap: (){
                Navigator.pushNamed(context,route)   ;           },
              child:  Container( width: widthSize*0.7,
              alignment: Alignment.centerLeft,
              
              height: 60,
              decoration: BoxDecoration(border: Border.all(color: AppColors.blue , width: 2,
              ), 
        borderRadius: BorderRadius.all(Radius.circular(10))    ),
            child: Row(children: [
            SizedBox(width: 5,),
              Icon(icon , color: AppColors.orange,size: 40,),
                          SizedBox(width: 5,),

              Text("$name", style: TextStyle(color: AppColors.blue ),),
            ],)
               
              ),

             );
             

 }














    return Scaffold(
      appBar: AppBar(title: Text("Mon Compte") , backgroundColor: AppColors.orange, ),
      drawer: AppDrawer(),
      body:
           SingleChildScrollView(

            
            child: Container(
              
              width:widthSize ,
              padding: EdgeInsets.only(top: 20),
              child:  Column(crossAxisAlignment: CrossAxisAlignment.center, 
                children: [Container(child:   Image.asset("assets/Logo.jpg" ,width: widthSize*0.4,), 
),
                                
                                  
Container(padding: EdgeInsets.all(50),
  child:  Column(children: [
  
                Text("Mon Compte" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold , color: AppColors.blue),)
                ,
              SizedBox(height: 10,),




              _buildInkwel(name: "Informations personnelles", route: "/personalinformation", icon:Icons.person),
              SizedBox(height:5 
              ),
                            _buildInkwel(name: "Changer le mot de passe", route: "/changepassword", icon:Icons.password) 
                             ,   SizedBox(height:5 
              ),
                                     _buildInkwel(name: "Véhicule", route: "/vehicle", icon:Icons.directions_car)
                                     , 
               



        
],))          




                



                



              ]),
            ),
          )
    );
  }
}























class PersonalInformationView extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}


class  _PersonalInformationState extends State<PersonalInformationView>{
  
  



  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();





  UserModel? _userModel;
    late UserViewModel _userViewModel;


 
    @override
  void initState() {
    
       _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    _fetchUserDetails();
    super.initState(); 
  

  }

  
  Future<void> _fetchUserDetails() async {

    final userModel = await _userViewModel.userDetails();
    setState(() {
      _userModel = userModel;
      
      initFields();
    });
  }
    

  void initFields() {
 if (_userModel != null ) {
      firstnameController.text = _userModel!.firstName;
      lastnameController.text = _userModel!.lastName;
      addressController.text = _userModel!.address;  
      telephoneController.text = _userModel!.telephone;  
      emailController.text = _userModel!.email;





 }    


    
  } 






  @override
  Widget build(BuildContext context) {
   double widthSize = MediaQuery.of(context).size.width;
    


    

    Widget _buildTextField({
      required TextEditingController controller,
      required String label,
      required bool obscureText,
     bool number = false 
        
    }) {
      return Container(
        width: widthSize * 0.8,
        height: 45,
        child: TextField(
          keyboardType: number ? TextInputType.number :  TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(8) 
             ,borderSide: BorderSide(color: AppColors.blue)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            
            labelText: label,
            labelStyle: TextStyle(color:AppColors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.blue, width: 1),
            ),
          ),
        ),
      );
    }













 return Scaffold(
  appBar: AppBar(title: Text("Informations personnelles") ,backgroundColor: AppColors.orange,), 

  body: 

  _userModel == null ? Center(
        child: CircularProgressIndicator(),
      ):
  
  SingleChildScrollView(child: Container(

    width: widthSize,
    height: MediaQuery.of(context).size.height*0.8,

    child: Column(
      

      children: [



        Container(child: 
        Column(children: [
          
   Icon(Icons.person , size: widthSize*0.3, color: AppColors.blue,),
  
   
 const SizedBox(height: 10),
_buildTextField(
 controller: firstnameController, label: 'Prénom', obscureText: false),
const SizedBox(height: 10),
_buildTextField(
 controller: lastnameController, label: 'Nom', obscureText: false),
 
const SizedBox(height: 10),
              _buildTextField(
                  controller: telephoneController, label: 'Téléphone', obscureText: false , number: true),
              const SizedBox(height: 10),
              _buildTextField(controller: addressController, label: 'Adresse', obscureText: false),
              const SizedBox(height: 10),
                 _buildTextField(controller: emailController, label: 'Adresse e-mail', obscureText: false),
      
        ]),)

,


                                         

 Container(
        margin: EdgeInsets.only(bottom: 10),
        child: MaterialButton(
          onPressed:( ) async { 

       bool result =     await _userViewModel.updatePersonalInformation(PersonalInformationModel(firstName: firstnameController.text, lastName: lastnameController.text, address: addressController.text, telephone: telephoneController.text, email: emailController.text ));
           if (result) {

                                Navigator.of(context).pop();
 } else {

                      
             showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Message"),
                          content: Text("Échec de la mise à jour"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            )
                          ],
                        );
                      },
                    ); 
                    }



          },
          
          textColor: Colors.white,
          color:  AppColors.orange,
          minWidth: widthSize * 0.4,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            
          ),
          child: Text("Enregistrer"),
          
          ))



 ],)
  ),)
 
 );
  }



















  
}
















class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey for Form

  late UserViewModel _userViewModel;




  @override
  void initState() {
       _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    super.didChangeDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;

    Widget _buildTextFormField({
      required TextEditingController controller,
      required String label,
      required bool obscureText,
      bool number = false,
      String? Function(String? value)? validator, // Updated validator function
    }) {
      return ConstrainedBox(
       
       constraints: BoxConstraints(maxWidth: widthSize*0.8,
       minHeight: 45
       ),
        child: TextFormField(
          validator: validator,
          keyboardType: number ? TextInputType.number : TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            labelText: label,
            labelStyle: TextStyle(color: AppColors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.blue, width: 1),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Changer le mot de passe"),
        backgroundColor: AppColors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: widthSize,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Form( // Wrap with Form widget
            key: _formKey, // Assign the GlobalKey to Form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    children: [
                      Icon(Icons.password, size: widthSize * 0.3, color: AppColors.blue),
                      const SizedBox(height: 10),
                      _buildTextFormField(
                        controller: passwordController,
                        label: 'Nouveau mot de passe',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }else if (value.length < 6) {
                      return 'Mot de passe : au moins 6 caractères';
                    }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextFormField(
                        controller: passwordController2,
                        label: 'Confirmer le mot de passe',
                        obscureText: true,
                        validator: (value) {
                          if (value != passwordController.text.trim()) {
                            return "Les mots de passe ne correspondent pas";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) { // Validate the Form
                        bool result = await _userViewModel.updatePassword(passwordController.text.trim());
                        if (result) {
                          Navigator.of(context).pop();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Message"),
                                content: Text("Échec de la mise à jour"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    textColor: Colors.white,
                    color: AppColors.orange,
                    minWidth: widthSize * 0.4,
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Modifier"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
















class VehicleView extends StatefulWidget {
  @override
  _VehicleViewState createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {

  

  List _allBrands =[]; 
    List _allVehicles =[]; 
        final TextEditingController vehicleController = TextEditingController();
  var  vehicleId;



  Future <void>  getAllBrands() async {



    
    _allBrands = await _vehicleViewModel.getBrands();




  }


  Future<void> getAllVehiclesByBrand (String id) async {
    _allVehicles = await _vehicleViewModel.getVehiclesByBrand(id);
  }


  VehicleModel? _vehicleModel;
  late VehicleViewModel _vehicleViewModel;


  @override
  void didChangeDependencies() {
 _vehicleViewModel = Provider.of<VehicleViewModel>(context, listen: false);
         getAllBrands();

    fetchVehicleModel();
        super.didChangeDependencies();
  }
   


 @override
  void initState() {

    
     
    super.initState();
  }










  

 
  void _showBrandSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selectioner la marque"),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _allBrands.length ,
              itemBuilder: (BuildContext context, int index) {
                return Card(  child:  ListTile(
                  
                  title: Text(_allBrands[index].name),
                  onTap: () async {
                    setState(() {
                      
                    });
                    Navigator.of(context).pop();
                 await  getAllVehiclesByBrand(_allBrands[index].id);
                    _showVehicleSelectionDialog();

                  },
                ));
              },
            ),
          ),
        );
      }
    );
  }





 
  void _showVehicleSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sélectionner le véhicule"),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _allVehicles.length ,
              itemBuilder: (BuildContext context, int index) {
                return Card(  child:  ListTile(
                  
                  title: Text(_allVehicles[index].name),
                  onTap: () {
                    setState(() {
                       vehicleController.text = _allVehicles[index].name;
                       vehicleId=_allVehicles[index].id;
                    });
                    Navigator.of(context).pop();

                  },
                ));
              },
            ),
          ),
        );
      }
    );
  }















  

  Future<void> fetchVehicleModel() async {
    // Attendre correctement le résultat de getVehicle
    _vehicleModel = await _vehicleViewModel.getVehicle();
    setState(() {}); // Re-render le widget après avoir obtenu le modèle
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;

 

return Scaffold(
    appBar: AppBar(title: Text("Véhicule") ,backgroundColor: AppColors.orange,), 

      body: _vehicleModel== null ? Center(
        child: CircularProgressIndicator(),
      ) :
       SingleChildScrollView(

        child: Container(
          
          width: widthSize,
          padding: EdgeInsets.only(top: 40),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                
                child:  Column(children: [ 
                                   Icon(Icons.directions_car, size: widthSize * 0.3, color: AppColors.orange),



                  SizedBox(height: 5,)

                  ,            if (_vehicleModel != null)                  Text(_vehicleModel!.name , style: TextStyle(fontWeight: FontWeight.bold),),

                ],)
                
                
                
                
                
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center
                    
                    ,
                      children: [
                      // titles 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                                 Text("Type de véhicule :" ,style: TextStyle(fontWeight: FontWeight.bold),),
                                                    SizedBox(height: 10,),
                                                       Text("Capacité de la batterie :" ,style: TextStyle(fontWeight: FontWeight.bold),),

                                               SizedBox(height: 10,),
                                                 Text("Puissance maximale en AC :" ,style: TextStyle(fontWeight: FontWeight.bold),),
                                                     SizedBox(height: 10,),
                                                 Text("Puissance maximale en DC :" ,style: TextStyle(fontWeight: FontWeight.bold),),

                          
                        ],
                      )



                    // values 
,

                       Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
            if (_vehicleModel != null)                  Text(_vehicleModel!.vehicleType ),
                           SizedBox(height: 10,),
             if (_vehicleModel != null)                 Text("${_vehicleModel!.batteryCapacityKwh } kWh" ),
                          SizedBox(height: 10,),
                    if (_vehicleModel != null)          Text("${_vehicleModel!.acChargerMaxPower } kW"  ),
                          SizedBox(height: 10,),
               if (_vehicleModel != null)                if (_vehicleModel!.dcChargerMaxPower != null) Text("${_vehicleModel!.dcChargerMaxPower } kW") else Text("Ne existe pas!")
                       


                        ],
                      )






                    ],)
                    
                     ],
                ),
              ),
              



              Column(
                
                children: [
                  Container(width: widthSize*0.8,
                    alignment: Alignment.centerLeft,
                    child: Text("Changer de véhicule" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold) ,)
                    ,),
                    
                    SizedBox(height: 10,),
                     Container(
        width: widthSize * 0.8,
        height: 40,
        child: TextField(
          controller: vehicleController,
          onTap: _showBrandSelectionDialog,
          readOnly: true,
          
          
          decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(10) 
             ,borderSide: BorderSide(color: AppColors.blue)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            labelText:"véhicule",
             

                        labelStyle: TextStyle(color:AppColors.blue),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color:AppColors.blue, width: 1),
            

            ),



            


          ),
        ),
      ),



                ],

              )
           
           ,
           SizedBox(height: 30,)
           
           
           ,
 Container(
        margin: EdgeInsets.only(bottom: 10),
        child: MaterialButton(
          onPressed:( ) async {


       bool result =    await _vehicleViewModel.updateVehicle(vehicleId);
          if (result) {

                                Navigator.of(context).pop();

             } else {

                      
             showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Message"),
                          content: Text("Échec de la mise à jour"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            )
                          ],
                        );
                      },
                    ); 
                    }


          }
             



 

,

  
          
          textColor: Colors.white,
          color:  AppColors.orange,
          minWidth: widthSize * 0.4,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            
          ),
          child: Text("Modifier"),
          
          ))
           
           
           
           
           
           
           
           
            ],
          ),
        ),
      ),
    );







  }
}
