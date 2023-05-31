import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/card.dart';
import 'package:habbit_tracker/provider/hobby_provider.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text('My Habits')),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        // mainAxisAlignment: MainAxisAlignment.center,
        child: StreamBuilder<QuerySnapshot>(
            stream: habitsSnap,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print('${snapshot.data?.docs} this is data');
              return (ListView(
                children: <Widget>[
                  Column(
                    children: context
                        .watch<Habits>()
                        .habits
                        .map(
                          (item) => HabitCard(
                            name: item['name'] ?? '',
                            description: item['description'] ?? '',
                            repeatTime: item['repeatTime'] ?? '',
                            duration: item['duration'] ?? '',
                            onTap: () => Navigator.pushNamed(context, '/add',
                                arguments: item),
                          ),
                        )
                        .toList(),
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
