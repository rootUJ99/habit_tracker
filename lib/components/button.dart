import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final String title;

  Button({
    @required this.onPressed,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(title, style: (TextStyle(fontSize: 20))),
      onPressed: onPressed,
      color: Colors.purple,
      textColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
    );
  }
}
