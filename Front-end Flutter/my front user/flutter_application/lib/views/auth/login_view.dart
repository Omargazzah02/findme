import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/user_login_request_model.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Fonction pour construire un champ de texte avec validation
    Widget buildTextField({
      required TextEditingController controller,
      required String label,
      bool obscureText = false,
      String? Function(String?)? validator, // Validateur de champ
    }) {
      return  ConstrainedBox(constraints:  BoxConstraints(minHeight: 45 , maxWidth: widthSize*0.8),
        
        child :   TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator, // Validator associé au champ
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.blue),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ));
    }

    // Fonction pour construire un bouton arrondi
    Widget buildRoundedButton({
      required String text,
      required VoidCallback onPressed,
      Color? color,
    }) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: MaterialButton(
          onPressed: onPressed,
          color: color ?? AppColors.orange,
          minWidth: widthSize * 0.4,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: widthSize,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Form(
            key: _formKey, // Utilisation de la clé du formulaire
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: widthSize * 0.5, child: Image.asset("assets/Logo.jpg")),
                    SizedBox(height: 20),
                    buildTextField(
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
                    buildTextField(
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

                     GestureDetector(
                      child:               Text ("Mot de passe oublié ?" ,style: TextStyle(decoration: TextDecoration.underline , color: AppColors.blue),),

                      
                      onTap: () async {

                        _showEmailDialog(context);


                         
                        
                      })


                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    buildRoundedButton(
                      text: "Connexion",
                      onPressed: () async {
                        // Valider le formulaire avant de procéder
                        if (_formKey.currentState!.validate()) {
                          UserLoginRequestModel userLoginRequestModel =
                              UserLoginRequestModel(
                            username: usernameController.text.trim(),
                            password: passwordController.text,
                          );

                          bool loginSuccess =
                              await authViewModel.login(userLoginRequestModel);
                          if (loginSuccess) {
                            Navigator.of(context).pushReplacementNamed("/account");
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
                      },
                      color: AppColors.orange,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/register");
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Créer un compte',
                          style: TextStyle(
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








void _showEmailDialog(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Entrez votre email'),
        content: Form(
          key: _formKey, // Déplacez la clé du formulaire ici
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer une adresse e-mail';
              }
              if (!value.contains('@')) {
                return 'Veuillez entrer un e-mail valide';
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme la boîte de dialogue
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String email = emailController.text;
                // Traitez l'email ici

                // Par exemple, vous pouvez afficher l'email dans la console ou envoyer une requête
                print('Email entré: $email');
              }
              else {
                
              }
            },
            child: Text('Envoyer'),
          ),
        ],
      );
    },
  );
}
