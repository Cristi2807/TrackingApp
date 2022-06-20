import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/pages/welcome.dart';

import '../services/auth_service.dart';
import '../wrapper.dart';

class Blocked extends StatelessWidget {
  const Blocked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Column(
        children: [
          Text('You are blocked'),
          MaterialButton(
            onPressed: () async {
              await authService.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}
