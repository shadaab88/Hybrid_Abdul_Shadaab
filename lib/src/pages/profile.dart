import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Hybrid_Abdul_Shadaab/src/controllers/logincontroller.dart';

class Signout extends StatefulWidget{
  @override
  _SignoutState createState() => _SignoutState();
}

class _SignoutState extends StateMVC<Signout> {

  LoginController _con;

  _SignoutState() : super(LoginController()) {
    _con = controller;
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> checkifuserloggedin()async {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      return Navigator.pushNamed(context, '/Welcome');
    } else {
      print('User is signed in!');
      return Navigator.pushNamed(context, '/Home');
    }
  });
  }
  

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     Size size = MediaQuery.of(context).size;
       var deviceHeight =  MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    // This size provide us total height and width of our screen
    return new WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(

          

          body: Align(
            alignment: Alignment.center,

          
            child: Column(
              children: [
                   SizedBox(
            height: size.height*.1,
          ),

                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 10
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('https://assets.vg247.com/current/2016/09/battlefield_1.jpg'),
                        fit: BoxFit.fill
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height*.1,
                ),


                Container(
                  height: size.height*0.045,
                  width: size.width*0.25,
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  child: FlatButton(
                    child: Text("Sign Out",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 12.0,color: Colors.red))) ,

                    textColor: Colors.white,
                    onPressed: () {
                      signout();
                      checkifuserloggedin();
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }
}