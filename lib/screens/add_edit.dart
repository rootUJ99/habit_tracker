import 'package:flutter/material.dart';
import 'package:habbit_tracker/provider/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habbit_tracker/push_notification_handler.dart';

typedef ListMapString = List<Map<String, String>>;

typedef MapDynamic = Map<String, dynamic>;

class AddTodo extends StatefulWidget {
  AddTodo({super.key, this.item});
  Map<String, dynamic>? item;
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

  final int defaultTime = DateTime.now().microsecondsSinceEpoch;

  final Map<String, String> defaultDuration = {
    'key': '1hour',
    'value': '1 hour',
  };

  final Map<String, dynamic> _formControllers = {
    'name': TextEditingController(),
    'description': TextEditingController(),
    'repeatTime': DateTime.now().microsecondsSinceEpoch,
    'duration': {
      'key': '1hour',
      'value': '1 hour',
    },
  };

  final ListMapString _duration = [
    {'key': '15mins', 'value': '15 mins'},
    {'key': '30mins', 'value': '30 mins'},
    {'key': '1hour', 'value': '1 hour'},
    {'key': '1.5hour', 'value': '1.5 hour'},
    {'key': '2hours', 'value': '2 hour'},
  ];

  MapDynamic createHabitMap() {
    return {
      'name': _formControllers['name']!.text,
      'description': _formControllers['description']!.text,
      'repeatTime': _formControllers['repeatTime'],
      'duration': _formControllers['duration']['key'],
      'id': widget.item?['id'] ?? UniqueKey().toString(),
    };
  }

  void addHabit(CollectionReference habitsCol) {
    context.read<Habits>().addHabit(createHabitMap(), habitsCol);
    LocalPushNotification.showNotification(
        header: 'item added', body: 'habit has been added');
  }

  void editHabit(CollectionReference habitsCol) {
    context.read<Habits>().updateHabit(createHabitMap(), habitsCol);
    LocalPushNotification.showNotification(
        header: 'item updated', body: 'habit has been updated');
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
    _formControllers['name'].text = widget.item?['name'] ?? '';
    _formControllers['description'].text = widget.item?['description'] ?? '';
    _formControllers['repeatTime'] = widget.item?['repeatTime'] ?? defaultTime;
    _formControllers['duration'] = _duration.firstWhere(
      (it) => it['key'] == widget.item?['duration'],
      orElse: () => defaultDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.item != null && widget.item!.containsKey('name')) {
    // print('${widget.item?['name']}');
    // }
    CollectionReference habits =
        FirebaseFirestore.instance.collection('habits');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('add habit'),
      ),
      body: Form(
        key: _addEditForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _formControllers['name'],
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
                controller: _formControllers['description'],
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
                                '${_formControllers['repeatTime']}'),
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
                              _formControllers['repeatTime'] =
                                  convertToMicroseconds(selectedTimeRTL);
                            });
                          }
                        },
                        child: Text(
                            'repeat weekly at ${convertToTimeofDay(_formControllers["repeatTime"].toString())}')),
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
                    children: _duration
                        .map((item) => ChoiceChip(
                              label: Text(item['value'].toString()),
                              selected: item['key'] ==
                                  _formControllers['duration']['key'],
                              onSelected: (value) {
                                setState(() {
                                  _formControllers['duration'] = item;
                                });
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
                    print("""
                      ${_formControllers['name']!.text}
                      ${_formControllers['description']!.text}
                      ${_formControllers['repeatTime']!.toString()}
                      ${_formControllers['duration']['key']}
                      ${_formControllers['id']}
                    """);
                    if (widget.item != null) {
                      editHabit(habits);
                    } else {
                      addHabit(habits);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('save habit'))
            ],
          ),
        ),
      ),
    );
  }
}
