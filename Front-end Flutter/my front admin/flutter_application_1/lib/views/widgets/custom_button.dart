 // Fonction pour construire un bouton arrondi
    import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';

Widget customButton({
      required String text,
      required VoidCallback onPressed,
      Color? color,
       required  BuildContext context
    }) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: MaterialButton(
          onPressed: onPressed,
          color: color ?? AppColors.orange,
          minWidth: MediaQuery.of(context).size.width * 0.4,
          height: 45, // Hauteur augmentée pour une meilleure ergonomie
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
