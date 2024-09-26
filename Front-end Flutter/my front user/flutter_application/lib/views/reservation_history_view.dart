import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/reservation_response_model.dart';
import 'package:flutter_application/viewmodels/reservation_view_model.dart';
import 'package:flutter_application/views/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ReservationHistoryView extends StatefulWidget {
  @override
  _ReservationHistoryViewState createState() => _ReservationHistoryViewState();
}

class _ReservationHistoryViewState extends State<ReservationHistoryView> {
  late ReservationViewModel _reservationViewModel;
  List<ReservationResponseModel>? reservations;
  bool _isLoading = true;


  @override
  void didChangeDependencies() {
  _reservationViewModel = Provider.of<ReservationViewModel>(context, listen: false);
   
    initReservations();  
    
      super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  
  }

  Future<void> initReservations() async {
    _isLoading=true;
    reservations = await _reservationViewModel.getReservationHistory();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historique des réservations"),
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
                  final String   reservationStatus =  getReservationStatus(reservation.status);
                  final Color reservationStatusColor = reservation.status == "Cancelled" ? Colors.red : Colors.green;
                    return Card(
                      elevation: 5, // Add shadow to the card
                      margin: EdgeInsets.all(8), // Add margin around the card
                      child: ListTile(
                        leading: Icon(Icons.history),
                        title: Text(
                          "Réservation ID: ${reservation.idReservation}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                       
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
                              _buildReservationDetail("Statut", reservationStatus , color : reservationStatusColor),
                           
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


  String getReservationStatus( String reservationStatus) {
    switch(reservationStatus) {
      case "Completed" :
       return "Terminée";
       case "Cancelled" : 
       return  "Annulée";
       default  : return "";

    }
  }














}
