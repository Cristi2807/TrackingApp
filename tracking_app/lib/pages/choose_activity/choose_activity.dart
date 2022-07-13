import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_navigation.dart';
import '../choose_activity/widgets/appbar.dart';
import 'on_activity.dart';

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
    'Cardio Fitness',
    'Workout',
    'Weightlifting',
    'Cycling',
    'Swimming',
    'Basketball',
    'Stair Climbing',
    'Badminton',
    'Football',
    'Social Dance',
    'Table Tennis',
    'Tennis',
    'Athletics',
    'Bowling',
    'Boxing',
    'Hiking',
    'Hunting',
    'Rugby',
    'Volleyball',
  ];

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(appBar: AppBar()),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text(
                'Select one',
                style: TextStyle(
                    color: Color(0xff262e5b),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                height: 250,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: const [
                    Text('Walking',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Running',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Cardio Fitness',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Workout',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Weightlifting',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Cycling',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Swimming',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Basketball',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Stair Climbing',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Badminton',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Football',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Social Dance',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Table Tennis',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Tennis',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Athletics',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Bowling',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Boxing',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Hiking',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Hunting',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Rugby',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                    Text('Volleyball',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                  ],
                  onSelectedItemChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Activity: ${listTextValues[_selectedValue]}',
                  style: TextStyle(
                      color: Color(0xff262e5b),
                      fontSize: 25,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 30),
              Text(
                  "Current time: " +
                      now.hour.toString() +
                      ":" +
                      now.minute.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              SizedBox(height: 35),
              SizedBox(
                height: 40,
                width: 100,
                child: TextButton(
                    child: Text('Start'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      onSurface: Colors.grey,
                      elevation: 5,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () async {
                      await db
                          .collection('users')
                          .doc(auth.currentUser?.uid.toString())
                          .collection('unfinished')
                          .doc("1")
                          .set({
                        'name': listTextValues[_selectedValue],
                        'time_begin': DateTime.now(),
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnActivity()));
                    }),
              ),
              Expanded(child: Column()),
              BottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}
