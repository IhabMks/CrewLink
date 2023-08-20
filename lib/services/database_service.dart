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

  //getting user groups
  Future gettingUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //create a group
  Future createGroup(String userName, String uid, String crewName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupname": crewName,
      "groupicon": "",
      "admin": "${uid}_$userName",
      "members": [],
      "groupid": "",
      "lastmessage": "",
      "lastsender": "",
      "lastmessagetime": ""
    });

    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${this.uid}_$userName"]),
      "groupid": groupDocumentReference.id
    });

    DocumentReference userDocumentReference = userCollection.doc(this.uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$crewName"]),
    });
  }
}
