import 'package:flutter/material.dart';

enum DurationType {
  fifneenMin('15 min'),
  thirtyMin('30 min'),
  hour('1 hour'),
  hourAndHalf('1 hour 30 min'),
  twohour('2 hour');

  const DurationType(this.value);
  final String value;
}

class HabitModel {
  String? name;
  String? description;
  int? repeatTime;
  TimeOfDay? repeatTimeWithHourMin;
  DurationType? duration;
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  String? id;
  int? intId;

  HabitModel({
    required this.name,
    required this.description,
    required this.repeatTime,
    required this.repeatTimeWithHourMin,
    required this.duration,
    this.id,
    this.intId,
  });

  HabitModel.withTextControllers({
    required this.repeatTime,
    required this.repeatTimeWithHourMin,
    required this.duration,
    required this.nameController,
    required this.descriptionController,
    this.id,
    this.intId,
  }) {
    name = nameController!.text;
    description = descriptionController!.text;
  }

  HabitModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        repeatTime = json['repeatTime'] as int?,
        repeatTimeWithHourMin = json['repeatTimeWithHourMin'],
        id = json['id'],
        intId = json['intId'],
        duration = DurationType.values
            .firstWhere((element) => element.value == json['duration']);
  toJson() {
    return {
      'name': name,
      'description': description,
      'repeatTime': repeatTime,
      'repeatTimeWithHourMin': repeatTimeWithHourMin.toString(),
      'duration': duration!.value,
      'id': id,
      'intId': intId,
    };
  }

  set setNameController(TextEditingController nameController) {
    this.nameController = nameController;
    name = nameController.text;
  }

  set setDescriptionontroller(TextEditingController descriptionController) {
    this.descriptionController = descriptionController;
    name = descriptionController.text;
  }
}
