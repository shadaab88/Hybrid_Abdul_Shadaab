import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:Hybrid_Abdul_Shadaab/src/controllers/logincontroller.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/index.dart';

class PhoneAuthVerify extends StatefulWidget{

  String phonenumber;
  PhoneAuthVerify({this.phonenumber});
  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState(phonenumber: phonenumber);
}

class _PhoneAuthVerifyState extends StateMVC<PhoneAuthVerify> {

 LoginController _con;
  String phonenumber;

  _PhoneAuthVerifyState( {
    this.phonenumber
    });
final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
       // TODO: implement build
     Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      key: _scaffoldkey,
      
      body: Column(
        children: [

          SizedBox(
            height: size.height/5,
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Enter 6-digit code',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              autofocus:true,
              controller: _pinPutController,
              withCursor: true,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          ),
          SizedBox(
            height: size.height/200,
          ),
          GestureDetector(
            onTap: (){
              _verifyPhone();
            },
            child: Text("Resend OTP",style: 
            TextStyle(color: Colors.blueAccent),),
          ),

           SizedBox(
            height: size.height/200,
          ),
          

 
        ],
      ),
    );
  }

  _verifyPhone() async {
    
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91"+phonenumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 40));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}