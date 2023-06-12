import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/card.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text('My Habits')),
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
                      return HabitCard(
                        name: item['name'] ?? '',
                        description: item['description'] ?? '',
                        repeatTime:
                            convertToTimeOfDay(item['repeatTime'] ?? ''),
                        duration: item['duration'] ?? '',
                        onTap: () => Navigator.pushNamed(context, '/add',
                            arguments: item),
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
