import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/reservation_request_model.dart';
import 'package:flutter_application/viewmodels/reservation_view_model.dart';
import 'package:flutter_application/views/show_reservations_view.dart';
import 'package:flutter_application/views/widgets/icon_help.dart';
import 'package:provider/provider.dart';

class ReservationView extends StatefulWidget {
  final String connectorId;
  final String station;
  final String startTime;
  final String endTime;
  final double price;
    final int  connectorTypeId ;



  ReservationView({
    required this.connectorId,
    required this.station,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.connectorTypeId
  });

  @override
  _ReservationViewState createState() => _ReservationViewState(
   connectorId: connectorId,
    station: station,
    startTime: startTime,
    endTime: endTime,
    price: price,
    connectorTypeId: connectorTypeId

  );
}

class _ReservationViewState extends State<ReservationView> {
  final String connectorId;
  final String station;
  final String startTime;
  final String endTime;
  final double price;
    final int  connectorTypeId ;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
    late ReservationViewModel _reservationViewModel;

  _ReservationViewState({
    required this.connectorId,
    required this.station,
    required this.startTime,
    required this.endTime,
    required this.price,
        required this.connectorTypeId

  });

  final _formKey = GlobalKey<FormState>();

@override
  void didChangeDependencies() {
   _reservationViewModel=  Provider.of<ReservationViewModel>(context, listen: false);
    super.didChangeDependencies();
  }


@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: Text("Réserver"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      icon: Image.asset("assets/connector_$connectorTypeId.png", width: 60),
                      label: "Connecteur:",
                      value: connectorId,
                    ),
                    SizedBox(height: 10),
                    _buildInfoRow(
                      icon: Image.asset("assets/stationcharge.png", width: 60),
                      label: "Station:",
                      value: station,
                    ),
                    SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icon(Icons.alarm, size: 30, color: Colors.orange),
                      label: "Date de début:",
                      value: startTime,
                      textHelp:
                      "Il s'agit de l'heure à laquelle vous arrivez à la station. Attention, assurez-vous de ne pas perdre de temps. Vous avez jusqu'à 15 minutes de retard ; au-delà, la réservation sera automatiquement annulée.",
                    ),
                    SizedBox(height: 10),
                    _buildInfoRow(
                      icon: Icon(Icons.alarm, size: 30, color: Colors.orange),
                      label: "Date de fin:",
                      value: endTime,
                    ),
                    SizedBox(height: 10),
                    _buildInfoRow(
                      icon: Icon(Icons.euro_rounded, size: 30, color: Colors.green),
                      label: "Prix estimé:",
                      value: "$price",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Paiement",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        number: true,
                        controller: cardNumberController,
                        label: "Numéro de carte bancaire",
                        width: widthSize * 0.8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer le numéro de carte bancaire";
                          }
                          if (!RegExp(r'^\d{4}-\d{4}-\d{4}-\d{4}$').hasMatch(value)) {
                            return "Format de carte invalide.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      _buildTextField(
                        controller: expirationDateController,
                        label: "Date d'expiration (MM/YY)",
                        width: widthSize * 0.8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer la date d'expiration";
                          }
                          if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
                            return "Format de date invalide. Utilisez MM/YY";
                          }
                          var now = DateTime.now();
                          var inputDate = DateTime(int.parse('20${value.split('/')[1]}'), int.parse(value.split('/')[0]));
                          if (inputDate.isBefore(now)) {
                            return "La date d'expiration doit être future";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      _buildTextField(
                        number: true,
                        controller: cvvController,
                        label: "Code de sécurité (CVV/CVC)",
                        width: widthSize * 0.8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer le code de sécurité";
                          }
                          if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
                            return "Code de sécurité invalide. Utilisez 3 ou 4 chiffres";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        color: AppColors.orange,
                        
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                          await  _addReservation();
                          }
                        },
                        child: Text("Réserver" , style: TextStyle(color: Colors.white),),
                        
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Future <void> _addReservation()  async {

 ReservationRequestModel reservationRequestModel =  ReservationRequestModel(connectorId: connectorId, startTime: startTime, endTime: endTime);
int?  statusCode  = await _reservationViewModel.addReservation(reservationRequestModel);
   if (statusCode == 201 || statusCode ==200)  {

    
                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShowReservationView()),
    );
 




   } else if (statusCode == 409) {
        _showAlert("Vous avez déjà une réservation en cours. Il n'est pas possible d'effectuer deux réservations simultanément.");

   }
   else {
            _showAlert("Une erreur interne est survenue.");

   }

   
   
  }








  

  Widget _buildInfoRow({
    required Widget icon,
    required String label,
    required String value,
    String? textHelp,
  }) {
    return Card( child: 
    ListTile(
      leading: icon,
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
      trailing: textHelp != null ? iconHelp(context: context, explanation: textHelp) : null,
    ));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required double width,
    bool number = false , 
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: number ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: AppColors.blue),
      ),
    );
  }



void _showAlert(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}












}




