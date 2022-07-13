import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  int _steps = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String today = DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: today)
        .get();

    for (var doc in querySnapshot.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          _steps += int.parse(doc.get('steps'));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            _steps.toString(),
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w900),
          ),
          Text(
            'Total Steps',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
