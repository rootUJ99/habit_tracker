import 'package:flutter/material.dart';
import 'package:habbit_tracker/screens/add.dart';
import 'package:habbit_tracker/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/add':
        return MaterialPageRoute(builder: (_) => AddTodo());
      case '/':
        // Validation of correct data type
        // if (args is List) {
        return MaterialPageRoute(
          builder: (_) => MyHomePage(data: args),
        );
        // }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
