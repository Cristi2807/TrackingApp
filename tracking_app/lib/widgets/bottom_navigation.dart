//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracking_app/pages/logout.dart';
import 'package:tracking_app/query.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        color: Color(0xffeff1f5),
        child: IconTheme(
          data: IconThemeData(
              color: Color(0xff262e5b),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(context,'/home');
                  },
                  child: Icon(
                      Icons.home,
                      size: 30
                  )
              ),
              GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(context,'/activity_history');
                    },
                  child: Icon(
                      Icons.event,
                      size: 30
                  )
              ),
              GestureDetector(
                  onTap: ()  async {
                    //final myUserId = FirebaseAuth.instance.currentUser?.uid;
                    DatabaseReference postListRef = FirebaseDatabase.instance.ref("activities");
                    DatabaseReference newPostRef = postListRef.push();
                    newPostRef.set({
                      "activity":"Walking",
                      "timestamp":-DateTime.now().millisecondsSinceEpoch.toInt(),
                    }).asStream();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser()));
                    },
                  child: Icon(
                  Icons.add_circle,
                  size: 40
                  )
              ),
              Icon(
                  Icons.settings,
                  size: 30
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LogoutPage()));
                    },
                  child:Icon(
                      Icons.person,
                  size: 30
              ),
              ),
          ]),
        ),
    );
  }
}