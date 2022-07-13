import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/pages/home/widgets/activities.dart';
import 'package:tracking_app/pages/home/widgets/recent_activities.dart';
import 'package:tracking_app/widgets/bottom_navigation.dart';
import 'package:tracking_app/pages/home/widgets/header.dart';

import '../../services/test.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Header(),
          Activities(),
          RecentActivities(),
          BottomNavigation(),
        ],
      ),
    );
  }
}