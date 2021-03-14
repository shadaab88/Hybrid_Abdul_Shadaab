import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'src/pages/index.dart';
import 'src/pages/welcome.dart';
// import 'src/helpers/app_config.dart' as config;
// import 'src/repository/user_repository.dart' as userRepo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Starter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFF44336),
        accentColor: Color(0xFFFF5252),
      ),
      home: Check(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class Check extends StatefulWidget{
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {

  Future<String> checkifuserloggedin()async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Welcome();
            },
          ),
        );
        // return Navigator.pushNamed(context, '/Welcome');
      } else {
        print('User is signed in!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MyHomePage();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: checkifuserloggedin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          print("Already Loggedin");
          return Scaffold(body: Center(child: CircularProgressIndicator()));

        } else if(!snapshot.hasData) {

          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        else{
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}