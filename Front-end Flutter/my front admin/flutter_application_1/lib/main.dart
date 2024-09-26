import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/brand/show_brands.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/widgets/auth_check.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:AuthCheck()
        ,
         routes: {
          "/login": (context) => LoginView(),
          "/showbrands": (context) => ShowBrands(),


 


        

        }
       

        


      );
      
        }
      
    
  }

