import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const MainAppBar({Key? key, required this.appBar,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff262e5b),
          size: 16,
        ),
      ),
      title: Text(
        'Activity',
        style: TextStyle(
          color: Color(0xff262e5b),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {},
            child: Icon(
                Icons.notifications,
                size: 16,
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              maximumSize: Size(30, 30),
              minimumSize: Size(30, 30),
              shape: CircleBorder(),
              primary: Color(0xffb5e8f7),
              onPrimary: Color(0xff262e5b),
            ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}