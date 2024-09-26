import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/views/account_view.dart';
import 'package:flutter_application/views/reservation_history_view.dart';
import 'package:flutter_application/views/search_stations_view.dart';
import 'package:flutter_application/views/show_reservations_view.dart';

import 'package:flutter_application/viewmodels/auth_view_model.dart';

class AppDrawer extends StatelessWidget {
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          Container(
            alignment: Alignment.center,
            height: 70, // Définir la hauteur souhaitée pour le DrawerHeader
            decoration: BoxDecoration(
              color: AppColors.orange
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.battery_charging_full),
            title: Text('Rechercher des stations'),
            onTap: () {
              _navigateWithAnimation(context, '/search');
            },
          ),
         
          ListTile(
            leading: Icon(Icons.car_repair_rounded),
            title: Text('Réservations en cours'),
            onTap: () {
              _navigateWithAnimation(context, '/reservations');
            },
          ),
            ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique des réservations'),
            onTap: () {
              _navigateWithAnimation(context, '/reservations-history');
            },
          ),

           ListTile(
            leading: Icon(Icons.person),
            title: Text('Mon Compte'),
            onTap: () {
              _navigateWithAnimation(context, '/account');
            },
          ),

            ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.red,),
            title: Text('Se déconnecter' ,style: TextStyle(color: Colors.red),),
            onTap: () async {
              await _authViewModel.logout();

              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);



            },
          ),

          
        ],
      ),
    );
  }
  

  void _navigateWithAnimation(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => _getPage(routeName),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  Widget _getPage(String routeName) {
    switch (routeName) {
      case '/search':
        return SearchStationsView(); // Remplacez par votre page de recherche
      case '/account':
        return AccountView();
          case '/reservations':
        return ShowReservationView();  
          case '/reservations-history':
        return ReservationHistoryView();  // Remplacez par votre page de compte
      default:
        return Scaffold(); // Retourne une page vide par défaut
    }
  }
}
