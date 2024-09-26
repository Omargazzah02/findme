import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/models/search_stations_request_model.dart';
import 'package:flutter_application/services/location_service.dart';
import 'package:flutter_application/viewmodels/search_stations_view_model.dart';
import 'package:flutter_application/views/my_map_view.dart';
import 'package:flutter_application/views/reservation_view.dart';
import 'package:flutter_application/views/widgets/app_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';



class SearchStationsView extends StatefulWidget {
  @override
  _SearchStationsViewState createState() => _SearchStationsViewState();
}

class _SearchStationsViewState extends State<SearchStationsView> {
  final LocationService _locationService = LocationService();
  bool displayStations = false;
  bool _loading = false;
  bool checkPosition = false ; 

  final ValueNotifier<int> _currentBatteryLevel = ValueNotifier<int>(0);
  final ValueNotifier<int> _desiredBatteryLevel = ValueNotifier<int>(0);
  late SearchStationsViewModel _searchStationsViewModel;
  List<dynamic>? chargingStations;


  @override
  void didChangeDependencies() {
    _searchStationsViewModel = Provider.of<SearchStationsViewModel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  checkPositionMeth();
  }
  

 Future<void> checkPositionMeth() async {
        checkPosition = await _locationService.getLocation(context);

  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Rechercher des stations"),
        backgroundColor: AppColors.orange,
      ),
      drawer: AppDrawer(),
      body: Container(
        width: widthSize,
        child: Column(
          children: [
            Container(
              color: AppColors.orange,
              height: heightSize * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBatteryLevelContainer(
                    context: context,
                    widthSize: widthSize,
                    title: "Batterie actuel",
                    batteryLevelNotifier: _currentBatteryLevel,
                  ),
                  _buildBatteryLevelContainer(
                    context: context,
                    widthSize: widthSize,
                    title: "Batterie cible",
                    batteryLevelNotifier: _desiredBatteryLevel,
                  ),
                  MaterialButton(
                    color: AppColors.blue,
                    onPressed: _searchStations,
                    child: Text("Rechercher", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            _loading
                ? Container(
                    height: heightSize * 0.5,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : !displayStations
                    ? SizedBox.shrink()

                    : Expanded(
                        child: ListView.builder(
                          itemCount: chargingStations!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> chargingStation = chargingStations![index];
                            List<dynamic> equipments = chargingStation["equipments"];


                            return Container(  margin: EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(border:Border(top: BorderSide(width: 0.4))),

                              child: Card(child: Column (children: [

                              ListTile(
                                trailing:IconButton(icon: Icon(Icons.location_on , color: Colors.red,), onPressed: () {   
                                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyMapView(latitude: chargingStation["latitude"],longitude : chargingStation["longitude"]  , title: chargingStation["address"],)),
    );
                                  },),
                                leading: Image.asset(
                                  "assets/stationcharge.png",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  
                                ),

                                

                                title: Text(chargingStation["address"],style:TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: RichText(text: TextSpan(
                                        style: TextStyle(  fontSize: 16.0, color: Colors.black),
                                        children: <TextSpan>[
                                            TextSpan(text: 'Distance: ', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14)),   TextSpan(text: "${chargingStation["distanceKm"].toString()+"km"}" , style: TextStyle(fontSize: 14)),
                                        TextSpan(text: "   "),
                                             TextSpan(text: 'Durée: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize:14)),   TextSpan(text: "${chargingStation["duration"].toString()}", style: TextStyle(fontSize: 14)),

                                             

                                                                                      


                                        ]


                                ),),

                          


                              ),                
                              
                              
                                   Row( children: equipments.map((equipment) { return Expanded(  child: Container( decoration: BoxDecoration(border: Border.all(color:AppColors.blue,width: 0.7)),
                                    child:InkWell(
                                    onTap: () {
                                     _showBottomSheet(context , equipment , chargingStation["address"]);
                                    },

                                    child:   Column( crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Text("${equipment["connectorType"]} ${equipment["currentType"]}",style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                                      
                                      Image.asset("assets/connector_${equipment["connectorTypeId"]}.png", width: 60,),
                                      Row (mainAxisAlignment:MainAxisAlignment.center,   children: [Icon(Icons.battery_charging_full , color: Colors.green) ,       Text("${equipment["chargingDuration"]}",style: TextStyle(fontWeight: FontWeight.bold), ),],)
                                    ,  Row (mainAxisAlignment:MainAxisAlignment.center,   children: [Icon(Icons.euro , color: Colors.green,) ,       Text("${equipment["price"]}",style: TextStyle(fontWeight: FontWeight.bold), ),],)


                  


                                  


                                     
                                     

                                  
                                  
                                   ]),

                                    



                                   ),) ); }).toList(),) // Conversion en liste nécessaire ici )


                              
                              
                              

                                                            




                           
                           
                          
                            ],)));
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatteryLevelContainer({
    required BuildContext context,
    required double widthSize,
    required String title,
    required ValueNotifier<int> batteryLevelNotifier,
  }) {
    return Container(
      width: widthSize * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: batteryLevelInputDialog(
              context: context,
              text: title,
              myvalueeNotifier: batteryLevelNotifier,
            ),
          ),
        ],
      ),
    );
  }

  void _searchStations() async {


  
    if (checkPosition) {
      
        if (_desiredBatteryLevel.value > _currentBatteryLevel.value) {
      if (mounted) {
          setState(() {
          _loading = true;
        });
      }

        SearchStationsRequestModel searchStationsRequestModel = SearchStationsRequestModel(
          currentBatteryLevel: _currentBatteryLevel.value,
          desiredBatteryLevel: _desiredBatteryLevel.value,
          latitude: _locationService.latitude,
          longitude: _locationService.longitude,
        );
        chargingStations = await _searchStationsViewModel.searchStations(searchStationsRequestModel);

        setState(() {
          _loading = false;
          displayStations = chargingStations != null;
                  if (chargingStations!=null && chargingStations!.isEmpty  ) {
                    showAlert(context, "Aucune station de recharge ne correspond à votre niveau actuel de batterie. Veuillez appeler le service SOS au 112.");

                  }

        });



      }
      
      
       else {
        showAlert(context, "Le niveau cible de la batterie ne peut pas être inférieur à celui actuel");
      }
    } else {
       Fluttertoast.showToast(
        msg: "Veuillez autoriser l'accès à la localisation pour utiliser cette fonctionnalité.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

Widget batteryLevelInputDialog({
  required BuildContext context,
  required String text,
  required ValueNotifier<int> myvalueeNotifier,
}) {
  int batteryLevel = myvalueeNotifier.value;

  return IconButton(
    icon: Icon(Icons.battery_full, color: AppColors.blue),
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(text),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Sélectionnez le niveau de batterie :'),
                    SizedBox(height: 10),
                    Slider(
                      value: batteryLevel.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: batteryLevel.toString(),
                      onChanged: (double value) {
                        setState(() {
                          batteryLevel = value.toInt();
                          myvalueeNotifier.value = batteryLevel;
                        });
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

void showAlert(BuildContext context, String message) {
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














  void _showBottomSheet(BuildContext context ,Map<String , dynamic> equipment , String station ) {
    List<dynamic> connectors = equipment["connectors"];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height*0.6,
          color: Colors.white,
          child: Column( crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Text("Connecteurs" , style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.bold), ),

            for (var connector in connectors) 
            
      Container( 
            decoration: BoxDecoration(border:Border(top: BorderSide(width: 0.8))),
            height: 50,
            child:    Row(
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                
                Row(children: [ Image.asset("assets/connector_${equipment["connectorTypeId"]}.png", width: 40,), Text("ID Connecteur: ",style:TextStyle(fontWeight: FontWeight.bold),) , Text(connector["id"]) , ],)
                   ,
               connector['availability'] ? MaterialButton(onPressed: (){  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservationView(connectorId: connector["id"] , station: station  , startTime:  equipment["startTime"],  endTime:  equipment["endTime"],price: equipment["price"], connectorTypeId: equipment["connectorTypeId"],)    )
    );
}, child: Text("Reserver" , style: TextStyle(color: Colors.white),) , color: AppColors.orange,) :  Text("Pas disponible" , style:TextStyle(color: Colors.red , fontWeight: FontWeight.bold),)


              ],



    
         
            
            )),
        

          ],)
        );
      },
    );
  }