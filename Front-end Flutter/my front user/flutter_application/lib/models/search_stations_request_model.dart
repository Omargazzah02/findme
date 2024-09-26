class SearchStationsRequestModel {


  
   int currentBatteryLevel ;
    int desiredBatteryLevel ;
     double latitude;
      double longitude;

      SearchStationsRequestModel ({required this.currentBatteryLevel , required this.desiredBatteryLevel , required this.latitude , required this.longitude });






      Map <String , dynamic> toJson() {
  return  {
    
        "currentBatteryLevel": currentBatteryLevel.toString(),
    "desiredBatteryLevel": desiredBatteryLevel.toString,
    "latitude": latitude.toString,
    "longitude":longitude.toString,
    


  };
}





}