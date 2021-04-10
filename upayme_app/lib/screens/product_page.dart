
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/services/firebase_services.dart';
import 'package:upayme_app/widgets/custom_actionbar.dart';
import 'package:upayme_app/widgets/image_swipe.dart';
import 'package:upayme_app/widgets/product_options.dart';

class ProductPage extends StatefulWidget {
  final String productID;
  ProductPage({this.productID});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductOption = "0";

  Future _addToSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUID())
        .collection("Saved")
        .doc(widget.productID)
        .set({"size": _selectedProductOption});
  }

  //This Future will Add selected Item to cart
  Future _addItemToCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUID())
        .collection("Cart")
        .doc(widget.productID)
        .set({"option": _selectedProductOption});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Successfully added item to cart"),);

  final SnackBar _snackBar2 = SnackBar(content: Text("Item Saved"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
            children: [
              FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //Building Map of gathered data
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> documentData = snapshot.data.data();

                //List of Images
                List imageList = documentData['images'];
                List productOptions = documentData['options'];

                _selectedProductOption = productOptions[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    //first Image
                  ImageSwipe(imageList: imageList,),
                    Padding(
                      padding: const EdgeInsets.only(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0,
                    bottom: 4.0,
                    ),
                      child: Text(
                        "${documentData['name']}",
                      style: Constants.boldheading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 24.0,
                        ),
                      child: Text(
                        "\$${documentData['price']}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['desc']}",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 24.0,
                      ),
                      child: Text("Select Option:",
                      style: Constants.regularDarkText,
                      ),
                    ),
                    ProductOptions(
                      productOptions: productOptions,
                      onSelected: (option) {
                        _selectedProductOption = option;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        
                        children: [
                          //Building Save Item Button
                          GestureDetector(
                            onTap: () async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_snackBar2);
                            },
                            child: Container(
                              width: 65.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                  "assets/images/tab_saved.png"
                                ),
                                height: 20.0,
                              )
                            ),
                          ),
                          //Building  Add Item To Cart Button
                          Expanded(
                            //Once cart button is selected confirmation message will pop up
                            child: GestureDetector(
                              onTap: () async {
                                await _addItemToCart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 60.0,
                                // Adds spacing on left before cart box
                                margin: EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                  //Centering Box text
                                  alignment: Alignment.center,
                                  child: Text("Add Item To Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600
                                  ) ,
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
            hasTitle: false,
            hasBackground: false,
          )
        ],
      )
    );
  }
}
