import 'package:flutter/material.dart';
import 'package:flutter_application/models/search_stations_request_model.dart';
import 'package:flutter_application/services/search_stations_service.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';

class SearchStationsViewModel extends ChangeNotifier {


  final SearchStationsService _searchStationsService = SearchStationsService();
  final AuthViewModel authViewModel = AuthViewModel();


Future <List<dynamic>?> searchStations(SearchStationsRequestModel searchStationsRequestModel) async {
      String? _token = await authViewModel.getToken();

List<dynamic>?  chargingStations =   await _searchStationsService.searchStations(_token, searchStationsRequestModel);


 return chargingStations;

 




}


}
