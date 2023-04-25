import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final String title;

  const Button({
    @required this.onPressed,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title, style: (TextStyle(fontSize: 20))),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
      ),
    );
  }
}
