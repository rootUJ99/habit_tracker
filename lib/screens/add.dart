import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            RaisedButton(
              child: Text('Add', style: (TextStyle(fontSize: 20))),
              onPressed: () => Navigator.pushNamed(context, '/'),
              color: Colors.purple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0)),
            )
            // RaisedButton()
          ],
        ),
      ),
    );
  }
}
