import 'package:flutter/material.dart';

enum ActivityType {
  first,
  second,
}

class TypeOfActivity {
  final AssetImage image;
  final String name;
  final ActivityType type;

  TypeOfActivity({
    required this.image,
    required this.name,
    required this.type,
  });
}

final List<TypeOfActivity> activities = [
  TypeOfActivity(image: AssetImage('assets/walking.jpg'), name: 'Walking', type: ActivityType.first),
  TypeOfActivity(image: AssetImage('assets/running.jpg'), name: 'Running', type: ActivityType.second),
  TypeOfActivity(image: AssetImage('assets/cardio_fitness.jpg'), name: 'Cardio Fitness', type: ActivityType.first),
  TypeOfActivity(image: AssetImage('assets/workout.jpg'), name: 'Workout', type: ActivityType.second),
  TypeOfActivity(image: AssetImage('assets/weightlifting.jpg'), name: 'Weightlifting', type: ActivityType.first),
  TypeOfActivity(image: AssetImage('assets/cycling.jpg'), name: 'Cycling', type: ActivityType.second),
  TypeOfActivity(image: AssetImage('assets/swimming.jpg'), name: 'Swimming', type: ActivityType.first),
  TypeOfActivity(image: AssetImage('assets/basketball.jpg'), name: 'Basketball', type: ActivityType.second),
  TypeOfActivity(image: AssetImage('assets/stair_climbing.jpg'), name: 'Stair Climbing', type: ActivityType.first),
];