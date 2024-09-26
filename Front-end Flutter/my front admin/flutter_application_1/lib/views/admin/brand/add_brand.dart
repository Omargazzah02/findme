import 'package:flutter/material.dart';
import 'package:flutter_application_1/viewmodels/admin_view_model.dart';
import 'package:flutter_application_1/views/admin/brand/show_brands.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_show_alert.dart';
import 'package:flutter_application_1/views/widgets/forms/admin/brand_form.dart';

class AddBrand extends StatefulWidget {

    @override
  _ShowBrandsState createState() => _ShowBrandsState();


}

class _ShowBrandsState  extends State<AddBrand>{

  late AdminViewModel  _adminViewModel ;
 TextEditingController _brandNameController = TextEditingController();
   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
@override
  void initState() {
     _adminViewModel = AdminViewModel();
    super.initState();
  }
   
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Marque")),
      body: Container(
        padding: EdgeInsets.all(30),
        width:  MediaQuery.of(context).size.width,
        child: Column(children: [
          BrandForm( brandNameController: _brandNameController, formKey: _formKey),
          SizedBox(height: 20,)
          ,
          customPostButton(context: context , text: "Ajouter" , onPressed: () async{
          if (_formKey.currentState?.validate() ?? false) {
         bool result = await _adminViewModel.addBrand(_brandNameController.text);
         if (result) {
              Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ShowBrands()),
);

         }

         else {

         customShowAlert(context, "Erreur de connexion survenue");


         }

          }
          })
          
          
          
        ]),
       
      )
        
    ) ;


  }
  
}