import 'package:flutter/material.dart';

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
                    // Navigator.of(context).pushNamed('/home');
                  },
                  child: Icon(
                      Icons.home,
                      size: 30
                  )
              ),
              GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/activity_history');
                    },
                  child: Icon(
                      Icons.event,
                      size: 30
                  )
              ),
              Icon(
                  Icons.add_circle,
                  size: 40
              ),
              Icon(
                  Icons.settings,
                  size: 30
              ),
              Icon(Icons.person,
                  size: 30
              ),
          ]),
        ),
    );
  }
}