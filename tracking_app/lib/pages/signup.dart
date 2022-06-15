import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'package:tracking_app/pages/login.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Color(0xff262e5b),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery
              .of(context)
              .size
              .height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Create an account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    await authService.createUserWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );

                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User? user = auth.currentUser;
                    final uid = user?.uid;
                    final db = FirebaseFirestore.instance;

                    db.collection('users').doc(uid.toString())
                        .set({
                    'first_name': "Johny",
                    'last_name': "Depp",
                    'age': 50,
                    'isDeleted':false,
                    'isBlocked':false,
                    'email': emailController.text,
                    'role': "user",
                    });

                    Navigator.pop(context);
                  },
                  color: Color(0xff262e5b),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(" Login", style: TextStyle(
                      color: Color(0xff262e5b),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}