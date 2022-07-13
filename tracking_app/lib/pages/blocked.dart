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
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
              ),
              Text('You have been blocked !',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 200.0,
              ),
              TextButton(
                  child: Text('Continue'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    onSurface: Colors.grey,
                    elevation: 5,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () async {
                    await authService.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Wrapper()));
                  }),
            ],
          ),
        ));
  }
}
