import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  int steps = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String today = DateTime.now().subtract(Duration(days:1)).day.toString() +
        DateTime.now().subtract(Duration(days:1)).month.toString() +
        DateTime.now().subtract(Duration(days:1)).year.toString();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: today)
        .get();

    for (var doc in querySnapshot.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          steps += int.parse(doc.get('steps'));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text('$steps');
  }
}
