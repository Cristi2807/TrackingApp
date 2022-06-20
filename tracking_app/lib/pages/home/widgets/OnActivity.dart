import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/pages/home/home.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class OnActivity extends StatefulWidget {
  const OnActivity({Key? key}) : super(key: key);

  @override
  State<OnActivity> createState() => _OnActivityState();
}

class _OnActivityState extends State<OnActivity> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        MaterialButton(
          onPressed: () async {
            await db
                .collection('activities')
                .doc(auth.currentUser?.uid.toString())
                .collection('unfinished')
                .doc("1")
                .get()
                .then((DocumentSnapshot snapshot) async {
              await FirebaseFirestore.instance
                  .collection('activities')
                  .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                  .collection('all')
                  .add({
                'name': snapshot['name'],
                'time_begin': snapshot['time_begin'],
                'kka': 30,
                'time': DateTime.now()
                    .difference(snapshot['time_begin'].toDate())
                    .inMinutes,
                'time_end': DateTime.now(),
              });
            });

            await db
                .collection('activities')
                .doc(auth.currentUser?.uid.toString())
                .collection('unfinished')
                .doc("1")
                .delete();

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: Text(
            'Stop activity',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    )));
  }
}
