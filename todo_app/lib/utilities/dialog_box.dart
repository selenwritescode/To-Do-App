// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_app/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[300],
      content: Container(
        padding: EdgeInsets.all(35),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Expanded(child: // it prevents to overflow  when we increase the font size.
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none, // remove the underline
                hintText: "Add a new task",
                hintStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.pink[50],
                ),
              ),
              style: TextStyle(color: Colors.white, overflow: TextOverflow.clip),
              maxLines: 3,
            ),
          ),

          // buttons -> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [ 
              // save button
              MyButton(text: "Save", onPressed: onSave),
              
              const SizedBox(width: 10),

              // cancel button
              MyButton(text: "Cancel", onPressed: onCancel),
            ],
          ),
        ],),
      ),
    );
  }
}