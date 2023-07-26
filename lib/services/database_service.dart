import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // reference for our users collection in the firebase database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // reference for our groups collection in the firebase database

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // create the user data
  Future createUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'groups': [],
      'profilePic': "",
      "uid": uid
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
