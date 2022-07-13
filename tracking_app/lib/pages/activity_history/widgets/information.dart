import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  double _distance = 0;
  int _time = 0, _energy = 0;

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
        _time += doc.get('time') as int;
        _distance += double.parse(doc.get('distance'));
        _energy += int.parse(doc.get('energy'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Statistics(value: _energy.toString(), unit: 'kcal', label: 'Calories'),
        Statistics(
            value: _distance.toStringAsFixed(2), unit: 'm', label: 'Distance'),
        Statistics(value: _time.toString(), unit: 'min', label: 'Minutes'),
      ],
    );
  }
}

class Statistics extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const Statistics({
    Key? key,
    required this.value,
    required this.unit,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(text: ' '),
                TextSpan(
                    text: unit,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ))
              ]),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
