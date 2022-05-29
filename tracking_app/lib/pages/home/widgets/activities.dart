import 'package:flutter/material.dart';
import '../../../models/type_of_activity.dart';


class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  ActivityType active = activities[0].type;

  void _changeActivity(ActivityType newType) {
    setState(() {
      active = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Choose an activity',
                    style: Theme.of(context).textTheme.headline1,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
        ),
        SizedBox(
            width: double.infinity,
            height: 100,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return Activity(activity: activities[index],
                      active: activities[index].type == active,
                      onTap: _changeActivity,
                  );
                },
              separatorBuilder: (context, index) => SizedBox(width: 20),
            ),
        ),
      ],
    );
  }
}

class Activity extends StatelessWidget {

  final TypeOfActivity activity;
  final bool active;
  final Function(ActivityType) onTap;

  const Activity({
  Key? key,
  required this.activity,
  this.active = false,
  required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(activity.type);
      },
      child: Container(
        height: 80,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              active
                  ? Colors.blueAccent.withOpacity(.5)
                  : Colors.white.withOpacity(.5),
              BlendMode.lighten
            ),
            image: activity.image,
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(10),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: active
                ? Colors.white
                : Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          child: Column(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.name),
              ]
          ),
        ),
      ),
    );
  }
}