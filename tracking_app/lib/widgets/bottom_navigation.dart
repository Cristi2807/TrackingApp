//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/pages/home/widgets/OnActivity.dart';

import '../pages/home/widgets/ChooseActivity.dart';
import '../services/auth_service.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    return Container(
      width: double.infinity,
      height: 80,
      color: Color(0xffeff1f5),
      child: IconTheme(
        data: IconThemeData(
          color: Color(0xff262e5b),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Icon(Icons.home, size: 30)),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/activity_history');
              },
              child: Icon(Icons.event, size: 30)),
          GestureDetector(
              onTap: () async {

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChooseActivity()));
              },
              child: Icon(Icons.add_circle, size: 40)),
          GestureDetector(
              onTap: () async {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => OnActivity()));
              },
              child: Icon(Icons.settings, size: 30)),
          GestureDetector(
            onTap: () async {
              await authService.signOut();
            },
            child: Icon(Icons.person, size: 30),
          ),
        ]),
      ),
    );
  }
}
