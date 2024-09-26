import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cable_model.dart';
import 'package:flutter_application_1/models/drop_down_item_model.dart';
import 'package:flutter_application_1/views/widgets/custom_dropdown.dart';
import 'package:flutter_application_1/views/widgets/custom_text_field.dart';
import 'package:flutter_application_1/views/widgets/forms/custom_dynamic_drop_down.dart';
import 'package:flutter_application_1/views/widgets/show_cable_selection_dialog.dart';

class VehicleForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController variantController;
  final TextEditingController modelController;
  final TextEditingController releaseYearController;
  final TextEditingController batteryCapacityKwh;
  final TextEditingController averageEnergyConsumptionKwhPerKm;
  final TextEditingController acChargerMaxPower;
  final TextEditingController dcChargerMaxPower;
  final List<Cable> cables;
  final List<DropdownItem> brands;
  final ValueNotifier<String?> brandId;
  final ValueNotifier<String?> vehicleType;
  final List<int> selectedCableIds;

  VehicleForm({
    required this.formKey,
    required this.variantController,
    required this.modelController,
    required this.releaseYearController,
    required this.batteryCapacityKwh,
    required this.averageEnergyConsumptionKwhPerKm,
    required this.acChargerMaxPower,
    required this.dcChargerMaxPower,
    required this.cables,
    required this.brands ,
    required this.brandId,
    required this.vehicleType,
    required this.selectedCableIds,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
           
                      if (brands.isNotEmpty) 

            CustomDropdown(
              hint: "Marque",
              items: brands,
              value: brandId.value,
              onChanged: (value) {
                brandId.value = value;
              },
              context: context,
              labelText: "Marque",
            ),
            SizedBox(height: 10),
            CustomDynamicDropdown(
              valueNotifier: vehicleType,
              items: ["car", "motorbike"],
              hintText: 'Type de véhicule',
            ),
            SizedBox(height: 10),
            customTextField(
              context: context,
              label: "Version",
              validator: (value) {
                
                return null;
              },
              controller: variantController,
            ),
            SizedBox(height: 10),
            customTextField(
              context: context,
              label: "Modèle",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer la modèle.";
                }
                return null;
              },
              controller: modelController,
            ),
            SizedBox(height: 10),
            customTextField(
              context: context,
              label: "Année de sortie",
              number: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer l'année de sortie.";
                }

                        final parsedValue = num.tryParse(value);

                if (parsedValue == null  ) 
                {
                  return "Veuillez entrer un nombre";
                }


                return null;
              },
              controller: releaseYearController,
            ),
            SizedBox(height: 10),
            customTextField(
              number: true,
              context: context,
              label: "Capacité de la batterie Kwh.",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer la capacité de la batterie";
                }
                           final parsedValue = num.tryParse(value);

                   if (parsedValue == null ) 
                {
                  return "Veuillez entrer un nombre";
                }
                return null;
              },
              controller: batteryCapacityKwh,
            ),
            SizedBox(height: 10),
            customTextField(
              number: true,
              context: context,
              label: "Consommation (kWh/km)",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer la consommation";
                }

                    final parsedValue = num.tryParse(value);



                   if ( parsedValue== null ) 
                {
                  return "Veuillez entrer un nombre";
                }
                return null;
              },
              controller: averageEnergyConsumptionKwhPerKm,
            ),
            SizedBox(height: 10),
            customTextField(
              number: true,
              context: context,
              label: "Puissance maximale (AC)",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer la Puissance maximale";
                }

                         final parsedValue = num.tryParse(value);

                  if (parsedValue == null ) 
                {
                  return "Veuillez entrer un nombre";
                }
                return null;
              },
              controller: acChargerMaxPower,
            ),
            SizedBox(height: 10),
            customTextField(
              
              context: context,
              
              label: "Puissance maximale (DC)",
              number: true,
              validator: (value) {
                if (value == null ||value.isEmpty) {
                                    return "Veuillez entrer la Puissance maximale";

                }

                

                
                final parsedValue = num.tryParse(value);

                   if (parsedValue== null ) 
                {
                  return "Veuillez entrer un nombre";
                }
                return null;
              },

              controller: dcChargerMaxPower,
            ),
            SizedBox(height: 10),
            MaterialButton(
              color: Colors.blue,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              onPressed: () {
                showCableSelectionDialog(
                  context,
                  cables,
                  selectedCableIds,
                );
              },
              child: Text(
                "Connecteurs compatibles",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
