 // Fonction pour construire un bouton arrondi
    import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';

Widget customPostButton({
      required VoidCallback onPressed,
     
       required  BuildContext context,
       required String text 
    }) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: MaterialButton(
          onPressed: onPressed,
          color: AppColors.orange,
          minWidth: MediaQuery.of(context).size.width * 0.5,
          height: 35, // Hauteur augmentée pour une meilleure ergonomie
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
           text,
            style: TextStyle(color: Colors.white, fontSize: 16), // Taille de texte ajustée
          ),
        ),
      );
    }
