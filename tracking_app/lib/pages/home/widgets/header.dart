import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          CustomPaint(
            painter: HeaderPainter(),
            size: Size(
              double.infinity,
              200,
            ),
          ),
          Positioned(
            top: 20,
            left: 15,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: CircleAvatar(
              minRadius: 25,
              maxRadius: 25,
              foregroundImage: AssetImage('assets/blank_profile_picture.jpg'),
            ),
          ),
          Positioned(
            top: 90,
            left: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                FutureBuilder<DocumentSnapshot>(
                    future: db
                        .collection('users')
                        .doc(auth.currentUser?.uid.toString())
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      // if (snapshot.hasError) {
                      //   return Text("Something went wrong");
                      // }

                      // if (snapshot.hasData && !snapshot.data!.exists) {
                      //   return Text("Document does not exist");
                      // }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          "${data['first_name']}",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        );
                      }

                      return Text("");
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backColor = Paint()..color = Color(0xff262e5b);
    Paint circles = Paint()..color = Colors.white.withAlpha(10);
    canvas.drawRect(
      Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
      backColor,
    );
    canvas.drawCircle(Offset(size.width * .6, 10), 55, circles);
    canvas.drawCircle(Offset(size.width * .55, 170), 20, circles);
    canvas.drawCircle(Offset(size.width * .2, size.height - 70), 40, circles);
    canvas.drawCircle(Offset(size.width - 25, size.height - 50), 70, circles);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
