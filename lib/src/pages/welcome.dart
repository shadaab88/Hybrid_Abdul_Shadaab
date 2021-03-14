import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Hybrid_Abdul_Shadaab/src/controllers/welcome.dart';

class Welcome extends StatefulWidget{
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends StateMVC<Welcome> {

  _WelcomeState() : super(WelcomeController()) {
  }

  @override

  void initState() {
      // TODO: implement initState
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return new WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height/5,),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                     Container(
                       height: size.height/4,
                       child: Image.asset("assets/offersploxLogo.png")
                     ),
                        SizedBox(height: size.height/8,),

                     Text(
                       "Let's Get Started",
                       style: TextStyle(fontWeight: FontWeight.w500,
                       fontSize: 20.0,),
                     ),
                      SizedBox(height: size.height*0.03,),

                       Container(
                        height: size.height*0.058,
                        width: size.width*0.85,
                         decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                        child: FlatButton(
                          child: Text("Log in",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.blueAccent))),
                          textColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Login');
                          },
                        ),
                      ),

                        SizedBox(height: size.height*0.03,),

                         Container(
                        height: size.height*0.058,
                        width: size.width*0.85,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end:
                                            Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
                                            colors: <Color>[
                                              Colors.deepPurple[400],
                                              Colors.deepPurple[300],
                                              Colors.blue,
                                              Colors.blueAccent[200],
                                            ], // red to yellow
                                            //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                                          ),
                                  //color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                        child: FlatButton(
                          child: Text("Register new account",style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 18.0,color: Colors.white))) ,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Signup');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}