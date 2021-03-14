import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'index.dart';

class SetupPassword extends StatefulWidget{

    String email;
    SetupPassword({this.email});
  @override
  _SetupPasswordState createState() => _SetupPasswordState(email:email);
}


class _SetupPasswordState extends StateMVC<SetupPassword> {

    String email;
    _SetupPasswordState({this.email});

  final GlobalKey<FormState> _setupFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pwdInputController;
  TextEditingController confirmpwdInputController;


  Future<String> checkifuserloggedin()async {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      // return Navigator.pushNamed(context, '/Welcome');
    } else {
      print('User is signed in!');
      
      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);

                  
    }
  });
  }

   Future<String> signup(String email, String password) async {
 try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(e.code, style: TextStyle(
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
    
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
     showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(e.code, style: TextStyle(
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
                } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(e.code, style: TextStyle(
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
                }

 bool errordikhaoP = false;

String pwdValidator(String value) {
    if (value.length < 4 || value.length == null) {
//      return 'Password must be longer than 8 characters';
      setState(() {
        errordikhaoP = true;
      });
    } else {
      setState(() {
        errordikhaoP = false;
      });
    }
  }

  bool switchview = true;

  void _toggle() {
    setState(() {
      switchview = !switchview;
    });
  }

  bool switchview2 = true;

  void _toggle2() {
    setState(() {
      switchview2 = !switchview2;
    });
  }
  

  @override
  initState() {
    pwdInputController = new TextEditingController();
    confirmpwdInputController = new TextEditingController();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     Size size = MediaQuery.of(context).size;

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
            SizedBox(height: size.height/118,),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: size.height*0.15,),

                 Text(
                   "Register an account",
                   style: TextStyle(fontWeight: FontWeight.bold,
                   fontSize: 24.0),
                 ),
                  SizedBox(height: size.height*0.01,),
             
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                        key: _setupFormKey,
                        //autovalidateMode: AutovalidateMode.always,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                controller: pwdInputController,
                                validator: pwdValidator,
                                obscureText: switchview,
                                
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Icon(
                              switchview
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 15.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                                  ),
                                  labelText: "Password",
                                  labelStyle:
                                  TextStyle(color:  Colors.grey.shade500),
                                  contentPadding: EdgeInsets.all(12),
                                  
                                  hintStyle: TextStyle(color: Colors.black),

                                  // focusedBorder: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20.0),
                                  //     borderSide: BorderSide(
                                  //         color: (errordikhaoP == true)?Colors.red:Colors.purple)),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20.0),
                                  //     borderSide: BorderSide(
                                  //         color: (errordikhaoP == true)?Colors.red:Colors.blueAccent)),
                                          
                                ),
                              ),
                            ),

                            

                             Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                controller: confirmpwdInputController,
                                validator: pwdValidator,
                                obscureText: switchview2,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  labelStyle:
                                  TextStyle(color:  Colors.grey.shade500),

                                    suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle2();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Icon(
                              switchview2
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 15.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                  hintStyle: TextStyle(color: Colors.black),

                                  // focusedBorder: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20.0),
                                  //     borderSide: BorderSide(
                                  //         color:(errordikhaoP == true)?Colors.red:Colors.purple)),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20.0),
                                  //     borderSide: BorderSide(
                                  //         color: (errordikhaoP == true)?Colors.red:Colors.blueAccent)),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

                    SizedBox(height: size.height*0.05,),

                     Container(
                    height: size.height*0.058,
                    width: size.width*0.85,
                                    decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(5 ),
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                            ),
                    child: FlatButton(
                      child: Text("Next",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.black))) ,
                     
                      textColor: Colors.white,
                      onPressed: () {
                        print("Next button pressed");

                          if (_setupFormKey.currentState.validate()) {
                         if (pwdInputController.text == confirmpwdInputController.text) {
                           signup(email,pwdInputController.text);
                           checkifuserloggedin();
                      }
                          }
                          else{
                            print("Error");
                          }
                      },
                    ),
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