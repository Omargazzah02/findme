import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/models/login_model.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/auth_view_model.dart';
import 'package:flutter_application_1/views/widgets/custom_button.dart';
import 'package:flutter_application_1/views/widgets/custom_dropdown.dart';
import 'package:flutter_application_1/views/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire
  String? _selectedRole; // Variable pour stocker le rôle sélectionné
  late AuthViewModel _authViewModel ;
 List<DropdownItem> items= [ DropdownItem(value: 'admin', text: 'Administrateur'),  DropdownItem(value: 'operator', text: 'Opérateur')    ];



@override
  void initState() {
    _authViewModel = AuthViewModel();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;


  

  

    // Fonction pour construire un sélecteur de rôle
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: widthSize,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Form(
            key: _formKey, // Utilisation de la clé du formulaire
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Alignement centré
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: widthSize * 0.5,
                  child: Image.asset("assets/Logo.jpg"),
                ),
                SizedBox(height: 20),
                customTextField(
                  context: context,
                  controller: usernameController,
                  label: "Nom d'utilisateur",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom d\'utilisateur';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                customTextField(
                  context: context,
                  controller: passwordController,
                  label: "Mot de passe",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
               CustomDropdown(hint: "Veuillez sélectionner un rôle" ,items: items, value: _selectedRole,  onChanged: (value) {  setState(() {   _selectedRole = value;   });      },  context: context , labelText: "Rôle", ),
                SizedBox(height: 20),
                customButton(
                  context: context,
                  text: "Connexion",
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false)  {

                      if (_selectedRole=="admin") {
                    bool result = await _authViewModel.login(LoginModel(username: usernameController.text.trim(), password: passwordController.text));
                     if (result) {

Navigator.of(context).pushNamedAndRemoveUntil('/showbrands', (Route<dynamic> route) => false);


                     } else {

                         showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                      "Nom d'utilisateur ou mot de passe incorrect. Veuillez réessayer"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    )
                                  ],
                                );
                              },
                            );
                      
                     }

                      }
                          
                

                      
                      
                    }
                  },
                  color: AppColors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



