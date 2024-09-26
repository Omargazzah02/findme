import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';


Widget iconHelp({
  required BuildContext context,
  required String explanation,
}) {
  return IconButton(
    icon: Icon(Icons.help_outline ,color: AppColors.blue,), // Icône de point d'interrogation
    onPressed: () {
      // Afficher l'explication
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Explication'),
          content: Text(explanation), // Utiliser explanation ici
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text('Fermer'),
            ),
          ],
        ),
      );
    },
  );
}




















