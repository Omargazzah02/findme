import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cable_model.dart';

void showCableSelectionDialog(
  BuildContext context,
  List<Cable> cables,
  List<int> selectedCableIds,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CableSelectionDialog(
        cables: cables,
        selectedCableIds: selectedCableIds,
      );
    },
  );
}

class CableSelectionDialog extends StatefulWidget {
  final List<Cable> cables;
  final List<int> selectedCableIds;

  CableSelectionDialog({
    required this.cables,
    required this.selectedCableIds,
  });

  @override
  _CableSelectionDialogState createState() => _CableSelectionDialogState();
}

class _CableSelectionDialogState extends State<CableSelectionDialog> {
  late List<Cable> cablesCopy;

  @override
  void initState() {
    super.initState();
    cablesCopy = widget.cables.map((cable) {
      return Cable(
        name: cable.name,
        id: cable.id,
        isSelected: widget.selectedCableIds.contains(cable.id),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sélectionnez les connecteurs'),
      content: SingleChildScrollView(
        child: Column(
          children: cablesCopy.map((cable) {
            return CheckboxListTile(
              title: Text(cable.name),
              value: cable.isSelected,
              onChanged: (bool? value) {
                setState(() {
                  cable.isSelected = value ?? false;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.selectedCableIds.clear();
            widget.selectedCableIds.addAll(
              cablesCopy.where((cable) => cable.isSelected).map((cable) => cable.id),
            );
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
      ],
    );
  }
}
