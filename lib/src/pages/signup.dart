import 'package:Hybrid_Abdul_Shadaab/src/helper/divider.dart';
import 'package:Hybrid_Abdul_Shadaab/src/helper/social_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Hybrid_Abdul_Shadaab/src/controllers/logincontroller.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/setpassword.dart';

import 'phoneauthverify.dart';

class Signup extends StatefulWidget{
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends StateMVC<Signup> {

  LoginController _con;

  _SignupState() : super(LoginController()) {
    _con = controller;
  }

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController phonenumberController;


  Future<String> checkifuserloggedin()async {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      // return Navigator.pushNamed(context, '/Welcome');
    } else {
      print('User is signed in!');
      // return Navigator.pushNamed(context, '/Home');
    }
  });
  }

  bool errordikhaoN = false;

   Future<String> validateMobile(String value) {
// Indian Mobile number are of 10 digit only

    if (value.length == null || value.length == 0)
      return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Mobile No/Email is null", style: TextStyle(
                              color: Colors.deepPurple
                          )),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
}
   );
    else if (value.length > 0 && value.length != 10){
      setState(() {
        errordikhaoN = true;
      });
      return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Mobile No is ill-formatted", style: TextStyle(
                              color: Colors.deepPurple
                          )),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
}
   );
   }
    // return 'Mobile Number must be of 10 digit';

    else {
      print(value.length);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhoneAuthVerify(phonenumber: phonenumberController.text)));
    }
      
  }

  

  @override
  initState() {
    phonenumberController = new TextEditingController();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     Size size = MediaQuery.of(context).size;
     
  
    
 

    // This size provide us total height and width of our screen
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: size.height/14,),

          

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,
                child: IconButton(icon:Icon( Icons.arrow_back_ios,color: Colors.black,),
                onPressed: (){
                  Navigator.pop(context);
                },)),
            ),
            SizedBox(height: size.height/10,),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 
            

                 Align(
                   alignment: Alignment.center,
                   child: Text(
                     "Register an account",
                     style: TextStyle(fontWeight: FontWeight.bold,
                     fontSize: 23.0),
                   ),
                 ),
                  SizedBox(height: size.height/38,),
             
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                        key: _signupFormKey,
                        // autovalidateMode: AutovalidateMode.always,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [



                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                 
                                controller: phonenumberController,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Mobile No/Email",
                                  labelStyle:
                                  TextStyle(color:  Colors.grey.shade500),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: 'name@email.com',
                                  hintStyle: TextStyle(color: Colors.grey),

                                  // focusedBorder: OutlineInputBorder(
                                  //    // borderRadius: BorderRadius.circular(20.0),
                                  //     borderSide: BorderSide(
                                  //         color: Colors.purple)),
                                  // enabledBorder: OutlineInputBorder(
                                  //    // borderRadius: BorderRadius.circular(20.0),
                                  //     borderSide: BorderSide(
                                  //         color: Colors.blueAccent)),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

              

              

                    SizedBox(height: size.height/80,),

                     Container(
                    height: size.height*0.058,
                    width: size.width*0.85,
                                    decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                            ),
                    child: FlatButton(
                      child: Text("Get OTP/SignUp",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15.0,color: Colors.black))) ,
                     
                      textColor: Colors.white,
                      onPressed: () {
                        print("Signup button pressed");
                                 bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(phonenumberController.text);
                                  if(emailValid){
                                  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SetupPassword(email: phonenumberController.text)));
                                }
                                else{
                                  validateMobile(phonenumberController.text);
                                        }
                      },
                    ),
                  ),

                  OrDivider(),

                  SizedBox(
                    height: size.height*0.01,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalIcon(
                          iconSrc: "assets/icons/google-icon.svg",
                          press: () {

                          }),
                      SocalIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {
                        },
                      ),

                    ],
                  ),

                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}