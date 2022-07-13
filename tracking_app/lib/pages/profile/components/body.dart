import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../../wrapper.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 40),
          ProfilePic(),
          SizedBox(height: 40),
          ProfileMenu(
            text: "My Account",
            icon: '',
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: '',
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: '',
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: '',
            press: () async {
              await authService.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
          ),
          //SizedBox(height: 75),
          //BottomNavigation(),
        ],
      ),
    );
  }
}
