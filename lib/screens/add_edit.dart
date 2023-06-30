import 'package:flutter/material.dart';
import 'package:habbit_tracker/model/habit_model.dart';
import 'package:habbit_tracker/provider/habit_provider.dart';
import 'package:habbit_tracker/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef ListMapString = List<Map<String, String>>;

typedef MapDynamic = Map<String, dynamic>;

class AddTodo extends StatefulWidget {
  AddTodo({super.key, this.item});
  HabitModel? item;
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final myController = TextEditingController();
  final _addEditForm = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  String getTime(TimeOfDay time) {
    final period = time.period.name;
    final min = time.minute;
    final hourPeriod = time.hourOfPeriod;

    return '$hourPeriod $min $period';
  }

  final HabitModel habitModel = HabitModel.withTextControllers(
    nameController: TextEditingController(),
    descriptionController: TextEditingController(),
    repeatTime: DateTime.now().microsecondsSinceEpoch,
    repeatTimeWithHourMin: TimeOfDay.now(),
    duration: DurationType.hour,
  );

  final int defaultTime = DateTime.now().microsecondsSinceEpoch;

  MapDynamic createHabitMap(HabitModel? habitModal) {
    return {
      ...habitModal?.toJson(),
      'id': widget.item?.id ?? UniqueKey().toString(),
    };
  }

  void addHabit(HabitModel habitModel, habitsCol) {
    context.read<Habits>().addHabit(createHabitMap(habitModel), habitsCol);
  }

  void editHabit(HabitModel habitModel, habitsCol) {
    context.read<Habits>().updateHabit(createHabitMap(habitModel), habitsCol);
  }

  void deleteHabit(HabitModel habitModel, habitsCol) {
    context.read<Habits>().deleteHabit(
        createHabitMap(habitModel), habitsCol, () => Navigator.pop(context));
  }

  TimeOfDay convertToTimeofDay(String timeStampEpoch) {
    // if (timeStampEpoch is String) {
    int ts = int.parse(timeStampEpoch);
    // }
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(ts);
    return TimeOfDay.fromDateTime(dateTime);
  }

  int convertToMicroseconds(TimeOfDay timeOfDay) {
    final dateTimenow = DateTime.now();
    final dateTimeEpoch = DateTime(dateTimenow.year, dateTimenow.month,
            dateTimenow.day, timeOfDay.hour, timeOfDay.minute)
        .microsecondsSinceEpoch;
    return dateTimeEpoch;
  }

  @override
  void initState() {
    super.initState();
    if (widget.item == null) return;
    habitModel.name = widget.item?.name ?? '';
    habitModel.description = widget.item?.description ?? '';
    habitModel.nameController!.text = widget.item?.name ?? '';
    habitModel.descriptionController!.text = widget.item?.description ?? '';
    habitModel.repeatTime = widget.item?.repeatTime ?? defaultTime;
    habitModel.duration = widget.item?.duration ?? DurationType.hour;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference habits =
        FirebaseFirestore.instance.collection('habits');

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('add habit'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => deleteHabit(habitModel, habits),
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Form(
            key: _addEditForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: habitModel.nameController,
                    onChanged: (value) => habitModel.name = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'habit name',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: habitModel.descriptionController,
                    onChanged: (value) => habitModel.description = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'description',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? selectedTimeRTL = await showTimePicker(
                                context: context,
                                initialTime: convertToTimeofDay(
                                    '${habitModel.repeatTime}'),
                                initialEntryMode: TimePickerEntryMode.inputOnly,
                                builder: (BuildContext context, Widget? child) {
                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: child!,
                                  );
                                },
                              );
                              print(selectedTimeRTL);
                              if (selectedTimeRTL != null) {
                                setState(() {
                                  habitModel.repeatTime =
                                      convertToMicroseconds(selectedTimeRTL);
                                  habitModel.repeatTimeWithHourMin =
                                      selectedTimeRTL;
                                });
                              }
                            },
                            child: Text(
                                'repeat weekly at ${convertToTimeofDay(habitModel.repeatTime.toString())}')),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Text('select duration'),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: DurationType.values
                            .map((item) => ChoiceChip(
                                  label: Text(item.value.toString()),
                                  selected: item == habitModel.duration,
                                  onSelected: (value) {
                                    habitModel.duration = item;
                                    setState(() {});
                                  },
                                ))
                            .toList(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (widget.item != null) {
                          editHabit(habitModel, habits);
                        } else {
                          addHabit(habitModel, habits);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('save habit'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
