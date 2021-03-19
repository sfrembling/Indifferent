import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/screens/home_page.dart';
import 'package:upayme_app/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //Firebase Initialized, snapshot hasError
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        //Initializing Firebase App
        if (snapshot.connectionState == ConnectionState.done) {

          //StreamBuilder will check login state changes live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //If streamSnapshot has Error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ),
                );
              }

              //if Connection state is active user check will begin
              if(streamSnapshot.connectionState==ConnectionState.active){
                //Get user info
                User _user=streamSnapshot.data;

                //Failed Login in if user not detected return to login screen
                if(_user==null){

                  return LoginPage();

                }
                else{

                  //if the user is logged in proceed to Homepage
                  return HomePage();
                }

              }
              //Display of Loading While Checking the authentication state
              return Scaffold(
                body: Center(
                  child: Text("Checking Authentication..",
                    style: Constants.regularHeading,
                  ),
                ),
              );}
          );
        }

        //Loading Display while Connecting to Firebase
        return Scaffold(
          body: Center(
            child: Text("Initialization of App..",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
