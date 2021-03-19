import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/widgets/custom_actionbar.dart';

class HomeTab extends StatelessWidget {
  //firebase Products import
  final CollectionReference _productsRef = FirebaseFirestore.instance.collection("UPayMe Products ");


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              //Error of Image import here 
              //Displaying Product data in list view
              if(snapshot.connectionState == ConnectionState.done){
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Container(
                      child: Image.network(
                       "${document.data()['images'][0]}"
                      ),
                    );
                  }).toList(),
                );
              }

              //Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            //hasTitle: false,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
