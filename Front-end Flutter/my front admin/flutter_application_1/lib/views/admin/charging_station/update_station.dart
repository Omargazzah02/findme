import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';
import 'package:flutter_application_1/views/widgets/custom_delete_button.dart';
import 'package:flutter_application_1/views/widgets/custom_post_button.dart';
import 'package:flutter_application_1/views/widgets/custom_text_field.dart';

class UpdateStation extends StatefulWidget {
    @override
  _StateUpdateStation createState() => _StateUpdateStation();

  

}
class _StateUpdateStation extends State<UpdateStation> {
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
                 customTextField(controller: controller, label: "Code postal", context: context , number: true),
          SizedBox(height: 10,),
              customTextField(controller: controller, label: "Opérateur Id", context: context ,),
          SizedBox(height: 10,),
            customTextField(controller: controller, label: "Latitude", context: context , number: true),
          SizedBox(height: 10,),
             customTextField(controller: controller, label: "Longitude", context: context , number: true),
          SizedBox(height: 10,),
        
        

          


customDeleteButton(onPressed: () {

}, context: context) , 
SizedBox(height: 10,),

      customPostButton(onPressed: () async {
        


      }, context: context, text: "Enregistrer") ],) ,
      )

      ),
    );





    
  }
  
}