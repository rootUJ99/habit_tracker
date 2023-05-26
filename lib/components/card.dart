import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final String name;
  final String description;
  final String repeatTime;
  final String duration;
  const HabitCard({
    super.key,
    required this.name,
    required this.description,
    required this.repeatTime,
    required this.duration,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: SizedBox(
          width: 300,
          height: 100,
          child: Column(
            children: [
              Text(name),
              Text(description),
              Text(repeatTime),
              Text(duration),
            ],
          )),
    );
  }
}
