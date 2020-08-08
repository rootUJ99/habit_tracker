import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/button.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  List _todos = [];
  void _addTodo() {
    setState(() {
      _todos.add('yo');
    });
  }

  void _goBack() {
    Navigator.pushNamed(context, '/', arguments: {'todos': _todos});
  }

  @override
  Widget build(BuildContext context) {
    print(_todos);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: TextField(
                decoration: InputDecoration(labelText: 'Enter Task'),
              ),
            ),
            Row(
              children: <Widget>[
                Button(
                  title: 'Add',
                  onPressed: _addTodo,
                ),
                Button(
                  title: 'Go back',
                  onPressed: _goBack,
                ),
              ],
            )
            // RaisedButton()
          ],
        ),
      ),
    );
  }
}
