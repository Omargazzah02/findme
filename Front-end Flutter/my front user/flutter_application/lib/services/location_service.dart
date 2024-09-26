
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {


 late  double latitude;
 late  double longitude;



Future<bool> getLocation(BuildContext context) async {


  // Vérifier et demander la  d'accès à la localisation
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Afficher un toast si la permission est refusée
      Fluttertoast.showToast(
        msg: "Veuillez autoriser l'accès à la localisation pour utiliser cette fonctionnalité.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  } else if (permission == LocationPermission.deniedForever) {
    // Afficher un toast si la permission est définitivement refusée
    Fluttertoast.showToast(
      msg: "Les permissions de localisation sont définitivement refusées. Veuillez les activer dans les paramètres.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    return false;
  }

  try {
    // Obtenir la position actuelle de l'utilisateur
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Enregistrer la latitude et la longitude récupérées
    latitude = position.latitude;
    longitude = position.longitude;

    
      return true;

    
  } catch (e) {
    // En cas d'erreur lors de la récupération de la localisation
    Fluttertoast.showToast(
      msg: "Impossible de récupérer votre position.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    return false; // Retourner false en cas d'échec
  }
}




  }





