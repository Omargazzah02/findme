import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/reservation_response_model.dart';
import 'package:flutter_application/viewmodels/reservation_view_model.dart';
import 'package:flutter_application/views/my_map_view.dart';
import 'package:flutter_application/views/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ShowReservationView extends StatefulWidget {
  @override
  _ShowReservationViewState createState() => _ShowReservationViewState();
}

class _ShowReservationViewState extends State<ShowReservationView> {
  late ReservationViewModel _reservationViewModel;
  List<ReservationResponseModel>? reservations;
  bool _isLoading = true;


  @override
  void initState() {
    _reservationViewModel = Provider.of<ReservationViewModel>(context, listen: false);
      initReservations();
    super.initState();
   
  }



  

  Future<void> initReservations() async {
    _isLoading=true;
    reservations = await _reservationViewModel.getAllReservations();
 if (mounted) {
     setState(() {
      _isLoading = false;
    });
 }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réservations en cours"),
        backgroundColor: AppColors.orange,
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : reservations == null || reservations!.isEmpty
              ? Center(child: Text("Aucune réservation trouvée."))
              : ListView.builder(
                  itemCount: reservations!.length,
                  itemBuilder: (context, index) {
                    final reservation = reservations![index];
                    return Card(
                      elevation: 5, // Add shadow to the card
                      margin: EdgeInsets.all(8), // Add margin around the card
                      child: ListTile(
                        title: Text(
                          "Réservation ID: ${reservation.idReservation}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        trailing:IconButton(icon:Icon(Icons.location_on , color:Colors.red) ,onPressed: ()  {
                           Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyMapView(latitude:reservation.latitude , longitude:  reservation.longitude ,title:  reservation.stationName,)),
    );
                          
                        },),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildReservationDetail('Station', reservation.stationName),
                              _buildReservationDetail('Connecteur ID', reservation.idConnector),
                              _buildReservationDetail('Connecteur', "${reservation.connectorType} ${reservation.currentType}"),
                              _buildReservationDetail('Date de début', reservation.startTime),
                              _buildReservationDetail('Date de fin', reservation.endTime),
                              _buildReservationDetail("Statut", "En cours " , color : Colors.green),
                              MaterialButton(onPressed: () async{
                                
                                 await   cancelReservation(reservation.idReservation);



                              }, color: Colors.red, child: Text("Annuler" , style: TextStyle(color: Colors.white),),) 
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildReservationDetail(String title, String detail ,{Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          ),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(color: color, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
        ],
      ),
    );
  }




 Future   <void> cancelReservation (int reservationId) async{




  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text("L'annulation de la réservation entraînera des frais. Êtes-vous sûr de vouloir continuer ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Non'),
          ),
          TextButton(
            onPressed: () async  {
                            Navigator.of(context).pop();



          bool result =    await _reservationViewModel.cancelReservation(reservationId);

          if (result) {


                         setState(() { 

                          initReservations();
                                                   _showAlert("Vous avez annulé la réservation avec succès.");

                          
                          

                         });


          } 
          else {
            _showAlert("Une erreur est survenue lors de l'annulation.");
          }

            
             
            },
            child: Text('Oui'),
          ),
        ],
      );
    },
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
