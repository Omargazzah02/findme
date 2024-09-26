import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/entity_model.dart';
import 'package:flutter_application_1/models/enum/route_enum.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/user/add_user.dart';
import 'package:flutter_application_1/views/widgets/app_drawer.dart';
import 'package:flutter_application_1/views/widgets/entity_list_page.dart';

class ShowUsers extends StatefulWidget {
  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  late AdminViewModel _adminViewModel;
  List<Entity> _users = [];
  bool _loading = true;
  bool _display = false;
 

  @override
  void initState() {
    super.initState();
    _adminViewModel = AdminViewModel();
    _initUsers();
  }

  Future<void> _initUsers() async {
    try {
      List<Entity>? users  = await _adminViewModel.getAllUsers();
     if(mounted) {
       
      setState(() {
        if (users != null) {
          _users = users; 
          _display = true;
        } else {
          _display = false;
        }
        _loading = false;
      });
     }
    } catch (error) {
     if(mounted) {
       setState(() {
        _display = false;
        _loading = false;
      });
     }
      // Optionnel : loguer l'erreur ou afficher une notification
      print('Erreur de chargement des marques: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilisateurs'),
        backgroundColor: AppColors.orange,
      ),
      drawer: AppDrawer()
      ,
      body: _loading
          ? Center(child: CircularProgressIndicator()) // Affiche un indicateur de chargement pendant le chargement des données
          : !_display
              ? Center(child: Text("Problème de connexion"))
              :  
                Stack(
                children: [
                  EntityListPage(
                  entities: _users,
                  iconLeading: Icons.person,
                   page: MyRoute.user
                ),
                Positioned(
            bottom: 20, // Ajuste cette valeur selon tes besoins
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUser()),
            );

                  }, // Ne fait rien
                ),
              ),
            ),
                )
                ],
               )
    );
  }
}
