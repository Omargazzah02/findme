import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/reservation_request_model.dart';
import 'package:flutter_application/models/reservation_response_model.dart';
import 'package:flutter_application/services/reservation_service.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';


class ReservationViewModel extends ChangeNotifier {

  final ReservationService reservationService = ReservationService();
   final AuthViewModel authViewModel = AuthViewModel();

    Future<int?> addReservation (ReservationRequestModel reservationRequestModel)  async{
            String? token = await authViewModel.getToken();

        int? response = await reservationService.addReservation(reservationRequestModel, token);

         return response;

    }




    Future <List<ReservationResponseModel>?>  getAllReservations ()  async{
              String? token = await authViewModel.getToken();

      List<ReservationResponseModel>? reservations =  await reservationService.getAllReservations(token);

      return reservations;

    }

       Future <List<ReservationResponseModel>?>  getReservationHistory ()  async{
              String? token = await authViewModel.getToken();

      List<ReservationResponseModel>? reservations =  await reservationService.getReservationHistory(token);

      return reservations;

    }



    Future <bool> cancelReservation (int reservationId)  async {
                    String? token = await authViewModel.getToken();

      bool result = await reservationService.cancelReservation(token, reservationId);
         return result;

    }
 

}