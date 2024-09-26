import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/auth_view_model.dart';
import 'package:flutter_application_1/views/admin/brand/show_brands.dart';
import 'package:flutter_application_1/views/admin/charging_station/show_stations.dart';
import 'package:flutter_application_1/views/admin/user/show_users.dart';
import 'package:flutter_application_1/views/admin/vehicle/chose_brand.dart';


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
            leading: Icon(Icons.label_important),
            title: Text('Marques'),
            onTap: () {
              _navigateWithAnimation(context, '/brand');
            },
          ),

           ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("Vehicules"),
            onTap: () {
              _navigateWithAnimation(context, '/vehicle');
            },
          ),

           ListTile(
            leading: Icon(Icons.person),
            title: Text("Utilisateurs"),
            onTap: () {
              _navigateWithAnimation(context, '/user');
            },
          ),
  ListTile(
            leading: Icon(Icons.electrical_services_sharp),
            title: Text("Stations de recharge"),
            onTap: () {
              _navigateWithAnimation(context, '/station');
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
      case '/brand':
        return ShowBrands(); // Remplacez par votre page de recherche
      case '/vehicle':
        return ChoseBrands();
          case '/user':
        return ShowUsers();
        case'/station':
        return ShowStations();
      
  
      
  
      default:
        return Scaffold(); // Retourne une page vide par défaut
    }
  }
}
