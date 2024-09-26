import 'package:flutter/material.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';
import 'package:flutter_application/viewmodels/reservation_view_model.dart';
import 'package:flutter_application/viewmodels/search_stations_view_model.dart';
import 'package:flutter_application/viewmodels/user_view_model.dart';
import 'package:flutter_application/viewmodels/vehicle_view_model.dart';
import 'package:flutter_application/views/account_view.dart';
import 'package:flutter_application/views/auth/login_view.dart';
import 'package:flutter_application/views/auth/register_view.dart';
import 'package:flutter_application/views/auth_check.dart';
import 'package:flutter_application/views/search_stations_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
ChangeNotifierProvider<VehicleViewModel>(create: (_) => VehicleViewModel()),
ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
ChangeNotifierProvider<SearchStationsViewModel>(create: (_) => SearchStationsViewModel()),
                                              ChangeNotifierProvider<ReservationViewModel>(create: (_) => ReservationViewModel()),



                                      


        // Ajoutez d'autres providers ici pour d'autres viewmodels si nécessaire
      ],
      child: MaterialApp(
        home:AuthCheck(),
        routes: {
          "/register": (context) => RegisterView(),
          "/login": (context) => LoginView(),
          "/account" :(context) => AccountView(),
          "/personalinformation" :(context) => PersonalInformationView(),
          "/vehicle" :(context) => VehicleView(),
          "/changepassword"  :(context) => ChangePasswordView(),
           "/search"  :(context) => SearchStationsView()


        

        },
      ),
    );
  }
}



