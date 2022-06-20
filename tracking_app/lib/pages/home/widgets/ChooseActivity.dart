import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OnActivity.dart';

class ChooseActivity extends StatefulWidget {
  const ChooseActivity({Key? key}) : super(key: key);

  @override
  State<ChooseActivity> createState() => _ChooseActivityState();
}

class _ChooseActivityState extends State<ChooseActivity> {
  int _selectedValue = 0;
  static const listTextValues = [
    'Walking',
    'Running',
    'Workout',
    'Swimming',
    'Cycling',
  ];

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 0),
                children: const [
                  Text('Walking'),
                  Text('Running'),
                  Text('Workout'),
                  Text('Swimming'),
                  Text('Cycling'),
                ],
                onSelectedItemChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CupertinoButton(
                child: Text('Choose here the activity'),
                onPressed: () => _showPicker(context),
              ),
              SizedBox(height: 30),
              Text('Activity: ${listTextValues[_selectedValue]}'),
              Text(now.hour.toString() + ":" + now.minute.toString() ),
              MaterialButton(
                onPressed: () async {
                  await db
                      .collection('activities')
                      .doc(auth.currentUser?.uid.toString())
                      .collection('unfinished')
                      .doc("1")
                      .set({
                    'name': listTextValues[_selectedValue],
                    'time_begin': DateTime.now(),
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OnActivity()));
                },
                child: Text('Start', style: TextStyle(color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
