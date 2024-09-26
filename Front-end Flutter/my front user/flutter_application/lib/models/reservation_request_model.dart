class ReservationRequestModel {
  String connectorId;
  String startTime;
  String endTime;

  ReservationRequestModel({
    required this.connectorId, 
    required this.startTime, 
    required this.endTime
  });




Map <String , dynamic> toJson() {
  return{
  "connectorId" : connectorId,
  "startTime"  :startTime,
  "endTime" : endTime



  };
}



}