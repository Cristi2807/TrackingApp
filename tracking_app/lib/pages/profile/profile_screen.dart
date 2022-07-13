import 'package:flutter/material.dart';
//import 'package:tracking/components/coustom_bottom_nav_bar.dart';
//import 'package:shop_app/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff262e5b),
      ),
      body: Body(),
    );
  }
}
