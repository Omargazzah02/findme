
class ReservationResponseModel 
{
 
      int idReservation;
     String idConnector;
     String connectorType;
     String currentType;

     String startTime;
     String endTime;
     String stationName ;
    double latitude;
     double longitude;
    String  status; 


    ReservationResponseModel ({required this.idConnector , required this.connectorType , required this.currentType , required this.endTime , required this.idReservation , required this.latitude , required this.longitude , required this.startTime , required this.stationName , required this.status});



 
  factory ReservationResponseModel.fromJson(Map<String, dynamic> json) {
    return ReservationResponseModel(
      idReservation: json['idReservation'],
      idConnector: json['idConnector'],
      connectorType: json['connectorType'],
      currentType: json['currentType'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      stationName: json['stationName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
    );
  }




}