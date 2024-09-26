import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/user_register_request_model.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';
import 'package:flutter_application/viewmodels/vehicle_view_model.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late VehicleViewModel vehicleViewModel;
  late AuthViewModel authViewModel;
  String vehiculeId = "";

  List _allBrands = [];
  List _allVehicles = [];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> getAllBrands() async {
    _allBrands = await vehicleViewModel.getBrands();
  }

  Future<void> getAllVehiclesByBrand(String id) async {
    _allVehicles = await vehicleViewModel.getVehiclesByBrand(id);
  }

  @override
  void didChangeDependencies() {

authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    vehicleViewModel = Provider.of<VehicleViewModel>(context, listen: false);
   
    getAllBrands();  
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
          title: Text("Sélectionner la marque"),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _allBrands.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(_allBrands[index].name),
                    onTap: () async {
                      setState(() {});
                      Navigator.of(context).pop();
                      await getAllVehiclesByBrand(_allBrands[index].id);
                      _showVehicleSelectionDialog();
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
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
              itemCount: _allVehicles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(_allVehicles[index].name),
                    onTap: () {
                      setState(() {
                        vehicleController.text = _allVehicles[index].name;
                        vehiculeId = _allVehicles[index].id;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;

    Widget _buildTextField({
      required TextEditingController controller,
      required String label,
      required bool obscureText,
      bool number = false,
      String? Function(String?)? validator,
    }) {
      return ConstrainedBox(
        constraints:  BoxConstraints(minWidth:  widthSize * 0.8,minHeight: 45), 
        
      
        child: TextFormField(
          keyboardType: number ? TextInputType.number : TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            labelText: label,
            labelStyle: TextStyle(color: AppColors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.blue, width: 1),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: widthSize,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(width: widthSize * 0.4, child: Image.asset("assets/Logo.jpg")),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: usernameController,
                  label: 'Nom d\'utilisateur',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom d\'utilisateur';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: emailController,
                  label: 'Adresse e-mail',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une adresse e-mail';
                    }
                    if (!value.contains('@')) {
                      return 'Veuillez entrer une adresse e-mail valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: firstnameController,
                  label: 'Prénom',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre prénom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: lastnameController,
                  label: 'Nom',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: telephoneController,
                  label: 'Téléphone',
                  obscureText: false,
                  number: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre numéro de téléphone';
                    }
                    else if (!RegExp(r'^(\+\d+|\d+)$').hasMatch(value) || value.length<6){ 
                                   return 'Veuillez entrer un numéro valide';


                    }
                    // Add more validation rules as needed
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: addressController,
                  label: 'Adresse',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: passwordController,
                  label: 'Mot de passe',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Mot de passe : au moins 6 caractères';
                    }
                    // Add more validation rules as needed
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ConstrainedBox( constraints:  BoxConstraints(minHeight: 45 , minWidth: widthSize*0.8)
                  ,
                  child: TextFormField(
                    validator:  (value ) {
                      if (value == null || value.isEmpty) {
                        return "Please choose a vehicle";
                      } else {
                        return null;
                      }
                    },
                    
                    controller: vehicleController,
                    onTap: _showBrandSelectionDialog,
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      labelText: "Vehicle",
                      labelStyle: TextStyle(color: AppColors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.blue, width: 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserRegisterRequestModel userModel = UserRegisterRequestModel(
                        username: usernameController.text.trim(),
                        email: emailController.text.trim(),
                        firstName: firstnameController.text.trim(),
                        lastName: lastnameController.text.trim(),
                        address: addressController.text.trim(),
                        password: passwordController.text,
                        telephone: telephoneController.text.trim(),
                        vehiculeId: vehiculeId,
                      );

                      int? responseCode = await authViewModel.register(userModel);

                      if (responseCode != 201) {
                        String text;
                        if (responseCode == 409) {
                          text = "Utilisateur déjà existant !";
                        } else if (responseCode == 0) {
                          text = "Erreur interne";
                        } else {
                          text = "Code d'erreur: $responseCode";
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                        
                              title: const Text("Message"),
                              content: Text(text),
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
                      } else {
                        usernameController.clear();
                        emailController.clear();
                        firstnameController.clear();
                        lastnameController.clear();
                        telephoneController.clear();
                        addressController.clear();
                        passwordController.clear();
                        vehicleController.clear();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Message"),
                              content: Text("Inscription réussie !"),
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
                  color: AppColors.orange,
                  minWidth: widthSize * 0.4,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/login");
                  },
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                        color: AppColors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
