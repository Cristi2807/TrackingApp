import 'dart:math';

import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent activities',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder:(context, index) => ActivityItem(),
                      )
                  )
                ]
            ),
        )
    );
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({Key? key}) : super(key: key);

  static const activities = [
    'Walking',
    'Running',
    'Cardio Fitness',
    'Workout',
    'Weightlifting',
    'Cycling',
    'Swimming',
    'Basketball',
    'Stair Climbing'
  ];

  @override
  Widget build(BuildContext context) {
    String activity = activities[Random().nextInt(activities.length)];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/activity_history');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffe1e1e1),
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffcff2ff),
                ),
                height: 35,
                width: 35,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/basketball.jpg'),
                          fit: BoxFit.fill,
                          )),
                  ),
                ),
            SizedBox(width: 20),
            Text(
                activity,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)
            ),
            Expanded(child: SizedBox()),
            SizedBox(width: 5),
            Icon(Icons.timer, size: 12),
            SizedBox(width: 5),
            Text(
                '30 min',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)
            ),
            SizedBox(width: 5),
            Icon(Icons.wb_sunny_outlined, size: 12),
            SizedBox(width: 5),
            Text(
                '30 kka',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)
            ),
            SizedBox(width: 20)
          ],),
      ),
    );
  }
}