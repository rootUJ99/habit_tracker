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
      // routes: {
      //   '/': (context) => MyHomePage(),
      //   '/add': (context) => AddTodo(),
      // },
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
