import 'package:flutter/material.dart';
import 'package:habbit_tracker/provider/hobby_provider.dart';
import 'package:provider/provider.dart';
// import 'package:habbit_tracker/components/button.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  List _todos = [];
  late Map<String, String> item;
  final myController = TextEditingController();
  // void _addTodo() {
  //   setState(() async {
  //     item = {'text': myController.text};
  //     _todos.add(myController.text);
  //     await Navigator.pushNamed(context, '/', arguments: item);
  //   });
  // }
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

  final Map<String, dynamic> _formControllers = {
    'name': TextEditingController(),
    'description': TextEditingController(),
    'repeatTime': TimeOfDay(hour: TimeOfDay.now().hour, minute: 00),
    'duration': {
      'key': '1hour',
      'value': '1 hour',
    },
  };

  final List<Map<String, String>> _duration = [
    {'key': '15mins', 'value': '15 mins'},
    {'key': '30mins', 'value': '30 mins'},
    {'key': '1hour', 'value': '1 hour'},
    {'key': '1.5hour', 'value': '1.5 hour'},
    {'key': '2hours', 'value': '2 hour'},
  ];

  @override
  Widget build(BuildContext context) {
    print(_todos);
    return Scaffold(
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
                            initialTime: _formControllers['repeatTime'],
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
                              _formControllers['repeatTime'] = selectedTimeRTL;
                            });
                          }
                        },
                        child: Text(
                            'repeat weekly at ${_formControllers["repeatTime"].toString()}')),
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
                              label: Text(item!['value'].toString()),
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
                      ${_formControllers['duration']['value']}
                    """);
                    context.read<Habits>().addHabit({
                      'name': _formControllers['name']!.text,
                      'description': _formControllers['description']!.text,
                      'repeatTime': getTime(_formControllers['repeatTime']),
                      'duration': _formControllers['duration']['value']
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('add habit'))
            ],
          ),
        ),
      ),
    );
  }
}
