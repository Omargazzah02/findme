import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<DropdownItem> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String labelText;

  CustomDropdown({
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
    required BuildContext context,
    required  this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(


    
      
      
      
      
      constraints:  BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),

    child:  DropdownButtonFormField<String>(



      decoration: InputDecoration(

        
            labelText: labelText,
            labelStyle: TextStyle(color: AppColors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        
    

      value: value,
      hint: Text(hint),
      items: items.map((DropdownItem item) {
        return DropdownMenuItem<String>(
          
          
          value: item.value,
          child:ConstrainedBox(
             constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
            child: Text(item.text ,
                            overflow: TextOverflow.ellipsis,


            ),)
        );
      }).toList(),
      onChanged: onChanged,
     
    ));
  }
}

