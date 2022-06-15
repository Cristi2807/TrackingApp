import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/pages/activity_history/activity_history.dart';
import 'package:tracking_app/pages/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:tracking_app/wrapper.dart';
import 'package:tracking_app/pages/signup.dart';
import 'package:tracking_app/pages/welcome.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
  )
  ;


  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Tracking App',
        theme: ThemeData(
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => Home(),
          '/activity_history': (context) => ActivityHistory(),
          '/welcome': (context) => WelcomePage(),
          '/signup': (context) => SignupPage(),
        },
        //initialRoute: 'wrapper',
        //home: Wrapper(),
        home: Wrapper(),
      ),
    );
  }
}