import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
        width: double.infinity,
        height: 80,
        color: Color(0xffeff1f5),
        child: IconTheme(data: IconThemeData(color: Color(0xff262e5b)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                     Navigator.of(context).pushNamed('/home');
                  },
                  child: Icon(Icons.home, size: 30)),
              GestureDetector(
                  onTap: () {
                     Navigator.of(context).pushNamed('/activity_history');
                    },
                  child: Icon(Icons.event, size: 30)),
              GestureDetector(
                  onTap: () async {
                    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

                    await ref.set({
                      "name": "John",
                      "age": 18,
                      "address": {
                        "line1": "100 Mountain View"
                      }
                    });
                        },
                  child:Icon(Icons.add_circle, size: 40)),
              Icon(Icons.settings, size: 30),
              GestureDetector(
                  onTap: () async {
                     await authService.signOut();
                     },
                  child: Icon(Icons.person, size: 30))
          ],),
        ),
    );
  }
}