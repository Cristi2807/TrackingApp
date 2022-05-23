import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Statistics(
            value: '345',
            unit: 'kcal',
            label: 'Calories'),
        Statistics(
            value: '3.6',
            unit: 'km',
            label: 'Distance'),
        Statistics(
            value: '1.5',
            unit: 'hr',
            label: 'Hours'),
      ],
    );
  }
}

class Statistics extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const Statistics({
    Key? key,
    required this.value,
    required this.unit,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: value,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900
            ),
            children: [
              TextSpan(
                text: ' '
              ),
              TextSpan(
                text: unit,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                )
              )
            ]),
        ),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}