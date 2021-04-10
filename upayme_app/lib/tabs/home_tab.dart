import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/screens/product_page.dart';
import 'package:upayme_app/widgets/custom_actionbar.dart';
import 'package:upayme_app/widgets/product_card.dart';

class HomeTab extends StatelessWidget 
{
  //firebase Products import
 // final CollectionReference _productsRef = FirebaseFirestore.instance.collection("Products ");


  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            //Gets Firebase Collection 'Products'
            future: FirebaseFirestore.instance.collection("Products ").get(),
            //Puts all of Products context into snapshot 
            builder: (context, snapshot){
              //Error of Image import here
              if (snapshot.hasError) {
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
                      onPressed: () 
                      {
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
          CustomActionBar(
            title: "Home",
            //hasTitle: false,
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
