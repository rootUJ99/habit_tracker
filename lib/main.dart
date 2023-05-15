import 'package:flutter/material.dart';
// import 'package:habbit_tracker/screens/add.dart';
// import 'package:habbit_tracker/screens/home.dart';
import 'package:habbit_tracker/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 40, 54, 122),
          useMaterial3: true),
    );
  }
}
