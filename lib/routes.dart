import 'package:flutter/material.dart';
import 'package:habbit_tracker/screens/add_edit.dart';
import 'package:habbit_tracker/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case '/add':
        return MaterialPageRoute(builder: (_) => AddTodo(item: args?['item']));
      case '/':
        // Validation of correct data type
        // if (args is List) {
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
      // }
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
