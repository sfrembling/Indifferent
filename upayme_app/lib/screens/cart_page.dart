import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/screens/product_page.dart';
import 'package:upayme_app/services/firebase_services.dart';
import 'package:upayme_app/widgets/custom_actionbar.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef.doc(_firebaseServices.getUID())
            .collection("Cart").get(),
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
              if(snapshot.connectionState == ConnectionState.done){
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ProductPage(productID: document.id,),
                        ));
                      },
                      child: FutureBuilder(
                        future: _firebaseServices.productsRef.doc(document.id).get(),
                        builder: (context, productSnap){

                         if(productSnap.hasError) {
                           return Container(
                             child: Center(
                               child: Text("${productSnap.error}"),
                             ),
                           );
                         }
                         if(productSnap.connectionState == ConnectionState.done){
                           Map _productMap = productSnap.data.data();
                         return Padding(
                           padding: const EdgeInsets.symmetric(
                             vertical: 16.0,
                             horizontal: 24.0,
                           ),
                           child: Row(
                             mainAxisAlignment:
                             MainAxisAlignment.start,
                             children: [
                               Container(
                                 width: 90,
                                 height: 90,
                                 child: ClipRRect(
                                   borderRadius:
                                   BorderRadius.circular(8.0),
                                   child: Image.network(
                                     "${_productMap['images'][0]}",
                                     fit: BoxFit.scaleDown,
                                   ),
                                 ),
                               ),
                               Container(
                                 padding: EdgeInsets.only(
                                   left: 16.0,
                                 ),
                                 child: Column(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       "${_productMap['name']}",
                                       style: TextStyle(
                                           fontSize: 18.0,
                                           color: Colors.black,
                                           fontWeight:
                                           FontWeight.w600),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets
                                           .symmetric(
                                         vertical: 4.0,
                                       ),
                                       child: Text(
                                         "\$${_productMap['price']}",
                                         style: TextStyle(
                                             fontSize: 16.0,
                                             color: Theme.of(context)
                                                 .accentColor,
                                             fontWeight:
                                             FontWeight.w600),
                                       ),
                                     ),
                                     Text(
                                       "Option : ${document.data()['size']}",
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           color: Colors.black,
                                           fontWeight:
                                           FontWeight.w600),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         );
                        }
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
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
            hasBackArrow: true,
            title: "Cart",
          )
        ],
      ),
    );
  }
}
