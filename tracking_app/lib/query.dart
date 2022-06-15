import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  //final String fullName;
  //final String company;
  //final int age;

  //AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection


    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    final db= FirebaseFirestore.instance;
    //CollectionReference users = FirebaseFirestore.instance.collection('users');
    
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return db.collection('users').doc(uid.toString())
          .set({
        'full_name': "fullName", // John Doe
        'company': "company", // Stokes and Sons
        'age': true, // 42
      });
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}