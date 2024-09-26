import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_utils/app_colors.dart';

class CustomDynamicDropdown extends StatelessWidget {
  final ValueNotifier<String?> valueNotifier;
  final List<String> items;
  final String hintText;

  CustomDynamicDropdown({
    required this.valueNotifier,
    required this.items,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints:  BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8)
    
   , child:     ValueListenableBuilder<String?>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return DropdownButtonFormField<String?>(
          
      decoration: InputDecoration(
        

        
            labelText: hintText,
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
          hint: Text(hintText),
          onChanged: (newValue) {
            if (newValue != null) {
              valueNotifier.value = newValue;
            }
          },
          items: items.map<DropdownMenuItem<String?>>((String item) {
            return DropdownMenuItem<String?>(









              
              value: item,
              child: Text(item),
            );
          }).toList(),
        );
      },
    ));
  }
}