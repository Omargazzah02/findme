 // Fonction pour construire un bouton arrondi
    import 'package:flutter/material.dart';

Widget customDeleteButton({
      required VoidCallback onPressed,
     
       required  BuildContext context
    }) {
      return Container(
        child: MaterialButton(
          onPressed: onPressed,
          color:  Colors.red,
          minWidth: MediaQuery.of(context).size.width * 0.5,
          height: 35, // Hauteur augmentée pour une meilleure ergonomie
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Supprimer",
            style: TextStyle(color: Colors.white, fontSize: 16), // Taille de texte ajustée
          ),
        ),
      );
    }
