import 'package:flutter/material.dart';
import 'package:flutter_application/app_colors.dart';
import 'package:flutter_application/services/location_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MyMapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String title;

  MyMapView({Key? key, required this.latitude, required this.longitude, required this.title}) : super(key: key);

  @override
  _MyMapViewState createState() => _MyMapViewState( latitude:latitude , longitude: longitude, title: title  );
}














class _MyMapViewState extends State<MyMapView> {
  final LocationService _locationService = LocationService();
  final http.Client _client = http.Client();
  String title;
  double latitude;
  double longitude;

  _MyMapViewState({
    required this.latitude,
    required this.longitude,
    required this.title
  });

  bool checkPosition = false;
  late double latitudeUser;
  late double longitudeUser;
  late List<MapMarker> tappedPoints;

  @override
  void initState() {
    super.initState();
    checkPositionMeth();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  Future<void> checkPositionMeth() async {
    try {
      checkPosition = await _locationService.getLocation(context);
      if (mounted) {
        setState(() {
          latitudeUser = _locationService.latitude;
          longitudeUser = _locationService.longitude;
          tappedPoints = [
            MapMarker(point: LatLng(latitude, longitude), title: title),
            MapMarker(point: LatLng(latitudeUser, longitudeUser), title: "Vous")
          ];
        });
      }
    } catch (e) {
      print('Error in checkPositionMeth: $e');
      // Gérer d'autres erreurs ici
    }
  }

  @override
  Widget build(BuildContext context) {
    late final List<Marker> markers;
    if (checkPosition) {
      markers = tappedPoints.map((marker) {
        // Récupérer le titre correspondant au LatLng
        // Fonction à définir
        return Marker(
          height: 80,
          width: 300,
          point: marker.point,
        child :Column(
            children: [
              Expanded(
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              Expanded(
                child: Text(
                  marker.title,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      }).toList();
    } else {
      markers = [];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: Text('Map'),
      ),
      body: !checkPosition
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Center(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(latitudeUser, longitudeUser),
                      initialZoom: 10,
                      minZoom: 0,
                      maxZoom: 19,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'net.tlserver6y.flutter_map_location_marker.example',
                        maxZoom: 19,
                      ),
                      MarkerLayer(markers: markers),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.directions),
                    onPressed: () async {
                      await launchUrl(Uri.parse("https://www.google.com/maps/dir/?api=1&origin=$latitudeUser,$longitudeUser&destination=$latitude,$longitude&travelmode=driving"));
                    },
                    label: Text("Directions"),
                  ),
                ),
              ],
            ),
    );


    
  }




  // Fonction pour récupérer le titre correspondant à un LatLng
}

class MapMarker {
  final LatLng point;
  final String title;

  MapMarker({required this.point, required this.title});
}
