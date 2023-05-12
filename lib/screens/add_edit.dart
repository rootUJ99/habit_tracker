import 'package:flutter/material.dart';
import 'package:habbit_tracker/components/button.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  List _todos = [];
  late Map<String, String> item;
  final myController = TextEditingController();
  void _addTodo() {
    setState(() async {
      item = {'text': myController.text};
      _todos.add(myController.text);
      await Navigator.pushNamed(context, '/', arguments: item);
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
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
                controller: myController,
                decoration: InputDecoration(labelText: 'Enter Task'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button(
                  title: 'Add',
                  onPressed: _addTodo,
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
