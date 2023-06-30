import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/widgets/habit_card.dart';
import 'package:habbit_tracker/model/habit_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference habits =
        FirebaseFirestore.instance.collection('habits');
    Stream<QuerySnapshot> habitsSnap = habits.snapshots();
    void _incrementCounter() {
      Navigator.pushNamed(context, '/add');
    }

    TimeOfDay convertToTimeOfDay(String s) {
      final dT = DateTime.fromMicrosecondsSinceEpoch(int.parse(s));
      return TimeOfDay.fromDateTime(dT);
    }

    // IconButton checkTheme() {
    //   return Theme.of(context).brightness == Brightness.dark
    //       ? IconButton(
    //           icon: const Icon(Icons.sunny),
    //           onPressed: () => Theme.of(context).brightness = Brightness.light,
    //         )
    //       : IconButton(
    //           icon: const Icon(Icons.nightlight_round),
    //           onPressed: () => print('dark'),
    //         );
    // }

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: const Text('My Habits'),
        actions: [
          // checkTheme(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        // mainAxisAlignment: MainAxisAlignment.center,
        child: StreamBuilder<QuerySnapshot>(
            stream: habitsSnap,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Text('no no');
              }
              print('${snapshot.data?.docs.map((e) => e.data())} this is data');
              return (ListView(
                children: [
                  Column(
                    children:
                        snapshot.data?.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> item =
                          document.data()! as Map<String, dynamic>;
                      HabitModel habit = HabitModel.fromJson({
                        ...item,
                        'repeatTime': int.parse(item['repeatTime'] ?? '0'),
                        'repeatTimeWithHourMin':
                            convertToTimeOfDay(item['repeatTime'] ?? ''),
                      });
                      print('this is habit $habit');
                      return HabitCard(
                        name: item['name'] ?? '',
                        description: item['description'] ?? '',
                        repeatTime:
                            convertToTimeOfDay(item['repeatTime'] ?? ''),
                        duration: item['duration'] ?? '',
                        onTap: () => Navigator.pushNamed(context, '/add',
                            arguments: {'item': habit}),
                      );
                    }).toList() as List<Widget>,
                  )
                ],
              ));
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        // tooltip: 'Increment',
        label: const Text("add habit"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
