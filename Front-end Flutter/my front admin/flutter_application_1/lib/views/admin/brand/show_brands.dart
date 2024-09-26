import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brand_model.dart';
import 'package:flutter_application_1/models/entity_model.dart';
import 'package:flutter_application_1/models/enum/route_enum.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/brand/add_brand.dart';
import 'package:flutter_application_1/views/widgets/app_drawer.dart';
import 'package:flutter_application_1/views/widgets/entity_list_page.dart';

class ShowBrands extends StatefulWidget {
  @override
  _ShowBrandsState createState() => _ShowBrandsState();
}

class _ShowBrandsState extends State<ShowBrands> {
  late AdminViewModel _adminViewModel;
  List<Entity> _brands = [];
  bool _loading = true;
  bool _display = false;

  @override
  void initState() {
    super.initState();
    _adminViewModel = AdminViewModel();
    _initBrands();
  }

  Future<void> _initBrands() async {
    try {
      List<BrandModel>? brands = await _adminViewModel.getAllBrands();
     if(mounted) {
       
      setState(() {
        if (brands != null) {
          _brands = brands.map((brand) => brand.toEntity()).toList();
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
        title: Text('Marques'),
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
                  entities: _brands,
                  iconLeading: Icons.label_important,
                   page: MyRoute.brand
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
              MaterialPageRoute(builder: (context) => AddBrand()),
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
