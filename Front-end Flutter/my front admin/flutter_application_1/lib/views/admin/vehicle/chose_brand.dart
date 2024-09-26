import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brand_model.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/vehicle/show_vehicles.dart';
import 'package:flutter_application_1/views/widgets/animations/page_route_builder.dart';
import 'package:flutter_application_1/views/widgets/app_drawer.dart';

class ChoseBrands extends StatefulWidget {
  @override
  _ChoseBrandsState createState() => _ChoseBrandsState();
}

class _ChoseBrandsState extends State<ChoseBrands> {
  late AdminViewModel _adminViewModel;
  List<BrandModel> _brands = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
     _adminViewModel = AdminViewModel();
    _fetchBrands();
    super.initState();
   
  }

  Future<void> _fetchBrands() async {
    try {
            List<BrandModel>? brands = await _adminViewModel.getAllBrands();

      if (brands != null )  {

          setState(() {
        _brands = brands;
        _isLoading = false;
      });
      }
    
    } catch (e) {
  if(mounted) {
        setState(() {
        _errorMessage = 'Failed to load brands.';
        _isLoading = false;
      });
  }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisir une marque'),
        backgroundColor: AppColors.orange,
        
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : ListView.builder(
                  itemCount: _brands.length,
                  itemBuilder: (context, index) {
                    
                    final brand = _brands[index];
                    return Card(
                      child: InkWell(
                        onTap: () {
                                 Navigator.of(context).push(      animationCustomPageRoute(ShowVehicles(id: brand.id,)));

                        },
                        child: ListTile(
                          leading: Icon( Icons.label_important,),
                      title: Text(brand.name),
                    ),
                      ),
                    );
                  },
                ),
    );
  }
}
