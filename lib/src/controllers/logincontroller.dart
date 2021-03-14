import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class LoginController extends ControllerMVC {

  GlobalKey<ScaffoldState> scaffoldKey;

  LoginController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
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
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> checkifloggedin()async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  sendverificationemail() async{
    User user = FirebaseAuth.instance.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  currentuser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print(auth.currentUser.uid);
    }
  }




  Future<String> phonenumberauthentication(String phonenumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // ANDROID ONLY
            // Sign the user in (or link) with the auto-generated credential
            await auth.signInWithCredential(credential);
          },
        );
      },
      verificationFailed: (FirebaseAuthException e)async {
        FirebaseAuth auth = FirebaseAuth.instance;

        await auth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }

            // Handle other errors
          },
        );
      },
      codeSent: (String verificationId, int resendToken)async {
        FirebaseAuth auth = FirebaseAuth.instance;


        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId){},
    );
  }
}