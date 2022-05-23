import 'package:flutter/material.dart';
import 'package:tracking_app/pages/home/home.dart';
import 'package:tracking_app/pages/login/login_screen.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState==ConnectionState.active){
          final User? user = snapshot.data;
          return user == null ? LoginScreen() : Home();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      });
  }
}
