import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_text_field.dart';

class AddStation extends StatefulWidget {
    @override
  _StateAddStation createState() => _StateAddStation();

  

}
class _StateAddStation extends State<AddStation> {
  TextEditingController controller = TextEditingController();



      @override
  void initState() {

    
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Station de recharge"), backgroundColor: AppColors.orange,),
      body: SingleChildScrollView(child:
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(children: [
          customTextField(controller: controller, label: "Adresse", context: context),
          SizedBox(height: 10,),
                 customTextField(controller: controller, label: "Code postal", context: context),
          SizedBox(height: 10,),
              customTextField(controller: controller, label: "Opérateur", context: context),
          SizedBox(height: 10,),
            customTextField(controller: controller, label: "Latitude", context: context),
          SizedBox(height: 10,),
             customTextField(controller: controller, label: "longitude", context: context),
          SizedBox(height: 10,),
        
        

          



      customPostButton(onPressed: () async {
        


      }, context: context, text: "Ajouter") ],) ,
      )

      ),
    );





    
  }
  
}