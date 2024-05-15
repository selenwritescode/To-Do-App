import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      
      onPressed: onPressed,
      color: Colors.pink[200],
      child: Text(
        text,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}