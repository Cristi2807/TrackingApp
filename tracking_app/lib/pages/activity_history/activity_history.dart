import 'package:flutter/material.dart';
import 'package:tracking_app/pages/activity_history/widgets/appbar.dart';
import 'package:tracking_app/widgets/bottom_navigation.dart';
import 'package:tracking_app/pages/activity_history/widgets/dates.dart';
import 'package:tracking_app/pages/activity_history/widgets/steps.dart';
import 'package:tracking_app/pages/activity_history/widgets/graph.dart';
import 'package:tracking_app/pages/activity_history/widgets/information.dart' hide Statistics;
import 'package:tracking_app/pages/activity_history/widgets/statistics.dart';

class ActivityHistory extends StatelessWidget {
  const ActivityHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar()),
        body: Column(
          children: const [
            Dates(),
            Steps(),
            Graph(),
            Information(),
            Divider(height: 30),
            Statistics(),
            SizedBox(height: 30),
            BottomNavigation()
          ]
        )
    );
  }
}