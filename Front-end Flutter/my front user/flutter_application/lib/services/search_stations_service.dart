import 'dart:convert';

import 'package:flutter_application/config.dart';
import 'package:flutter_application/models/search_stations_request_model.dart';
import 'package:http/http.dart' as http;


class SearchStationsService {
    final String url = Config.baseUrl;


   Future <List<dynamic>?> searchStations (String? token , SearchStationsRequestModel searchStationsRequestModel) async {


   try {
    final response = await http.get(Uri.parse("$url/station/search?currentBatteryLevel=${searchStationsRequestModel.currentBatteryLevel}&desiredBatteryLevel=${searchStationsRequestModel.desiredBatteryLevel}&latitude=${searchStationsRequestModel.latitude}&longitude=${searchStationsRequestModel.longitude}"),
    headers: {'Authorization' : 'Bearer $token' ,'Content-Type': 'application/json'}

    
    );

    print(response.statusCode);
    print(searchStationsRequestModel.latitude );
    print( searchStationsRequestModel.longitude);

    if (response.statusCode==200) {
      return json.decode(response.body);
    }


    else {
      return null;
    }

  



      




    } catch(e) {
            print(e);

      return null ; 


    }



   }


}










