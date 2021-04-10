import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUID(){
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productsRef = FirebaseFirestore.instance.collection("Products ");

  //user -> userID -> Cart -> ProductID
  final CollectionReference userRef = FirebaseFirestore.instance.collection("Users");

}
