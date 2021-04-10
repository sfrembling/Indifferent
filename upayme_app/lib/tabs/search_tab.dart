import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/screens/product_page.dart';
import 'package:upayme_app/services/firebase_services.dart';
import 'package:upayme_app/widgets/custom_input.dart';
import 'package:upayme_app/widgets/product_card.dart';

class SearchTab extends StatefulWidget 
{

  @override
  _SearchTabState createState() => _SearchTabState();
  
}

class _SearchTabState extends State<SearchTab> 
{
  
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) 
  {
    return Container(
      child: Stack(
        children: [
          if(_searchString.isEmpty)
          Center(
            child: Container(
            child: Text("Search Results", style: Constants.regularDarkText,)
            ),
          )
          else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.orderBy("name")
            //Boundarys of the inputed search words 
                .startAt([_searchString])
                .endAt(["$_searchString\ufBff"])
                .get(),
            builder: (context, snapshot)
            {
              //Error of Image import here
              if (snapshot.hasError) 
              {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //Displaying Product data in list view
              // if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData)
              {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document)
                  {
                    return ProductCard(
                      title: document.data()['name'],
                      //imageUrl: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(productID: document.id,
                                ),
                          ),
                        );
                      },
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
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
              hintText: "Search here. . .",
              onSubmitted: (value)
              {
                 setState(()
                 {
                   _searchString = value;
                 });
              },
            ),
          ),
        ],
      )
    );
  }
}
