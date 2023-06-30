import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final String title;

  const Button({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
      ),
      child: Text(title, style: (const TextStyle(fontSize: 20))),
    );
  }
}
