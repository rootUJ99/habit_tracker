import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final String name;
  final String description;
  final TimeOfDay repeatTime;
  final String duration;
  final Function? onTap;
  const HabitCard({
    super.key,
    required this.name,
    required this.description,
    required this.repeatTime,
    required this.duration,
    this.onTap,
  });

  String getTime(TimeOfDay time) {
    final period = time.period.name;
    final min = time.minute;
    final hourPeriod = time.hourOfPeriod;

    return '$hourPeriod $min $period';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () => onTap != null ? onTap!() : () {}(),
        child: SizedBox(
            width: double.maxFinite,
            // height: 100,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0),
                  ),
                  Text(
                    description,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.2),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Chip(
                          avatar: const Icon(Icons.timelapse),
                          label: Text(getTime(repeatTime))),
                      const SizedBox(width: 10),
                      Chip(
                          avatar: const Icon(Icons.repeat),
                          label: Text(duration)),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
