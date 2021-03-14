import 'package:flutter/material.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/home.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/index.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/login.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/phoneauthverify.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/signup.dart';
import 'src/pages/welcome.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case '/Welcome':
        return MaterialPageRoute(builder: (_) => Welcome());
      case '/Login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/Signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/Index':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/Home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/PhoneAuthVerify':
        return MaterialPageRoute(builder: (_) => PhoneAuthVerify());

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}