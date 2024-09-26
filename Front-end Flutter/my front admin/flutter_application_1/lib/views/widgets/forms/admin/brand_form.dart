import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class BrandForm  extends StatelessWidget {
  BrandForm({ required this.brandNameController ,required this.formKey});
TextEditingController brandNameController ;  
   GlobalKey<FormState> formKey;




  @override
  Widget build(BuildContext context) {
    
    return Form(
      key:  formKey,
      child: Column(children: [
    
      
      customTextField(controller: brandNameController, label: "Marque", context: context,
      
      validator:  (value ) {
        if (value == null  || value.isEmpty) {
          return"Veuillez entrer la marque";
        }
        else {
          return null ; 
        }
      })

    ],));
  }
 
  
}