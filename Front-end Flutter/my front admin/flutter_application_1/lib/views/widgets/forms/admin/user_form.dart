import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/views/widgets/custom_dropdown.dart';
import 'package:flutter_application_1/views/widgets/custom_text_field.dart';
import 'package:flutter_application_1/views/widgets/forms/custom_dynamic_drop_down.dart';

class UserForm extends StatelessWidget {
  UserForm({
   required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.telephoneController,
    required this .addressController,
    required this.passwordController,
    required this.vehicles,
    required this.role,

    required this.vehicleId,
  
  });

    final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController ; 
  final TextEditingController firstNameController ; 
  final TextEditingController lastNameController ; 
  final TextEditingController telephoneController ; 
  final TextEditingController addressController ; 
    final TextEditingController? passwordController ; 

  final ValueNotifier<String?> role;
  final ValueNotifier<String?> vehicleId;
    final List<DropdownItem> vehicles;




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // Utilisation de ValueListenableBuilder pour écouter les changements de role
            ValueListenableBuilder<String?>(
              valueListenable: role,
              builder: (context, currentRole, child) {
                // `currentRole` contient la valeur actuelle de `role`
                print('La valeur de role a changé: $currentRole');

                // Exemple d'action en fonction de la valeur de `role`
                return Column(
                  children: [
                    CustomDynamicDropdown(
                      valueNotifier: role,
                      items: ["user", "admin"],
                      hintText: 'Role',
                    ),
                    if (currentRole == 'user')
                  Column (children: [
                    SizedBox(height: 10,),


                    
                       CustomDropdown(
              hint: "Véhicule",
              items: vehicles,
              value: vehicleId.value,
              onChanged: (value) {
                vehicleId.value = value;
              },
              context: context,
              labelText: "Véhicule",
            ),

                  ],)
 
                  
                    
                     
                  ],
                );
              },
            ),
            SizedBox(height: 10,),
            customTextField(
              controller: usernameController,
              label: "Nom d'utilisateur",
              context: context,

               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom d\'utilisateur';
                }
                return null;
              },
              
            ),
               SizedBox(height: 10,),
            customTextField(
              controller: firstNameController,
              label: "Prénom",
              context: context,

               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un prénom';
                }
                return null;
              },
            ),

                   SizedBox(height: 10,),
            customTextField(
              controller: lastNameController,
              label: "Nom",
              context: context,

               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            customTextField(
              controller: emailController,
              label: "Email",
              context: context,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un email';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
            ),
        
            SizedBox(height: 10,),
            customTextField(
              controller: telephoneController,
              label: "Téléphone",
              context: context,
              number: true,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un numéro de téléphone';
                }
                if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                  return 'Veuillez entrer un numéro de téléphone valide';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            customTextField(
              controller: addressController,
              label: "Adresse",
              context: context,
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une adresse';
                }
                return null;
              },
            ),

           if (passwordController != null ) 
           Column(children: [
              SizedBox(height: 10,),
            customTextField(
              controller:passwordController! ,
              label: "Mot de passe",
              context: context,
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
           ],)
          
          ],
        ),
      ),
    );
  }
}
