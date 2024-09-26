
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brand_model.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/brand/show_brands.dart';
import 'package:flutter_application_1/views/widgets/custom_delete_button.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_show_alert.dart';
import 'package:flutter_application_1/views/widgets/forms/admin/brand_form.dart';

// ignore: must_be_immutable
class UpdateBrand extends StatefulWidget {
  String id ;
  UpdateBrand({required this.id });
  @override
  _UpdateBrandState createState() => _UpdateBrandState();

}




class _UpdateBrandState extends State<UpdateBrand>{





@override
  void initState() {
    _adminViewModel = AdminViewModel();
    initForm();
     super.initState();
  }
 late AdminViewModel  _adminViewModel ;
TextEditingController _idController = TextEditingController();
 TextEditingController _brandNameController = TextEditingController();
   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool loading = false ; 

   

   



 





  Future <void > initForm () async {
    
setState(() {
  loading=true;
});

       BrandModel? brandModel      = await _adminViewModel.getBrandById(widget.id);


       if (brandModel != null ) {
        _idController.text=brandModel.id;
        _brandNameController.text = brandModel.name;

setState(() {
  loading = false;



});   


    }
     
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Marque"),),
      body :Container(padding: EdgeInsets.all(30),
        width:  MediaQuery.of(context).size.width,
      child: loading ? Center(child:  CircularProgressIndicator(),)
      :  Column(children: [
        BrandForm( brandNameController: _brandNameController, formKey: _formKey)
        ,
         SizedBox(height: 30,),
         customDeleteButton(onPressed: () async {
          
     bool  result = await    _adminViewModel.deleteBrand(widget.id);

     if (result) {
                         Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ShowBrands()),
);


     } else {
                   customShowAlert(context, "Une erreur est survenue lors de la tentative de suppression. Si cette marque est associée à des véhicules, veuillez d'abord supprimer ces véhicules ou modifier leur marque avant de réessayer.");


     }

          


          


         }, context: context ) , 
          customPostButton(onPressed: () async {

        bool result = await    _adminViewModel.updateBrand(_brandNameController.text, widget.id);
        if (result) {
                     Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ShowBrands()),
);

        }
        else {
                   customShowAlert(context, "Erreur de connexion survenue");

        }


         }, context: context, text: "Enregistrer")
        
        
            
      ]),
      
      )

    );
 
  }

  
}
