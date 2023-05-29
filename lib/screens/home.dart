import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/card.dart';
import 'package:habbit_tracker/provider/hobby_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  void handleTap() {
    print('Yeah you are tapping shit outa it');
  }

  void handleLongPress() {
    print('You are pressing it tooo hard');
  }

  @override
  Widget build(BuildContext context) {
    void _incrementCounter() {
      Navigator.pushNamed(context, '/add');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Habits')),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        // mainAxisAlignment: MainAxisAlignment.center,
        child: (ListView(
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
                      onTap: () =>
                          Navigator.pushNamed(context, '/add', arguments: item),
                    ),
                  )
                  .toList(),
            )
          ],
        )),
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
