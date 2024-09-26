  // Fonction pour construire un champ de texte avec validation
    import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';

Widget customTextField({
      required TextEditingController controller,
      required String label,
      bool obscureText = false,
      String? Function(String?)? validator,
      bool number =false ,
      required BuildContext context, // Validateur de champ
      void Function()? onTap,
        
    }) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 45, maxWidth: MediaQuery.of(context).size.width * 0.8),
        child: TextFormField(
          onTap: onTap,
          
          controller: controller,
          obscureText: obscureText,
          validator: validator, // Validator associé au champ
            keyboardType: number? TextInputType.number  : TextInputType.text,
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
        ),
      );
    }

 

 