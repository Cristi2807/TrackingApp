import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:tracking_app/pages/home/home.dart';
import 'package:tracking_app/pages/welcome.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final db = FirebaseFirestore.instance;

    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return WelcomePage();
            } else {
              return StreamBuilder<DocumentSnapshot>(
                stream:
                    db.collection('users').doc(user.uid.toString()).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!['isBlocked']) {
                    Fluttertoast.showToast(
                      msg: 'This account has been blocked!',
                    );
                    authService.signOut();
                    return WelcomePage();
                  }
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!['isDeleted']) {
                    Fluttertoast.showToast(
                      msg: 'This account has been deleted!',
                    );
                    authService.signOut();
                    return WelcomePage();
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    if (!snapshot.data!['isBlocked'] &&
                        !snapshot.data!['isDeleted']) return Home();
                  }
                  return CircularProgressIndicator();
                },
              );
            }
          } else {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
