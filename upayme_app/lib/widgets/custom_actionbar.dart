import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/screens/cart_page.dart';
import 'package:upayme_app/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  //Page title
  final String title;
  //Option to display title on page or not
  final bool hasTitle;
  //Page back arrow
  final bool hasBackArrow;
  //check to see if image has a background
  final bool hasBackground;
  CustomActionBar({this.title, this.hasBackArrow, this.hasTitle, this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;


    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0,0),
          end: Alignment(0,0),
        ): null
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        left: 24.0,
        right: 24.0,
        bottom: 34.0,
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(_hasBackArrow)
              //When back button is selected previous page will become current page
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  //Positioning box text to center
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(
                      "assets/images/back_arrow.png"
                    ),
                    color: Colors.white,
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
            //If page has title then text will be displayed
            if(_hasTitle)
            Text(
              title ?? "Title ",
              style: Constants.boldheading,
            ),
            //Creates Push button for Cart page
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),
                ));
              },
              child: Container(
                width: 30.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                //Positioning box text to center
                alignment: Alignment.center,
                //Cart Item Button
                child: StreamBuilder(
                  stream: _userRef.doc(_firebaseServices.getUID()).collection("Cart").snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;

                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;

                    }
                    return Text(
                        "$_totalItems" ?? "0",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        )
                    );
                  }
                )
              ),
            )
          ],
        ),
    );
  }
}
