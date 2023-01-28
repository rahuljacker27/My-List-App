import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user Input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Here .."
              ),
            ),

            //buttons -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // save button
              MyButton(text: "Save", onPressed: onSave ),
              // cancel button
              MyButton(text: "Cancel", onPressed: onCancel )
            ],)
          ],
        ),
      ),
    );
  }
}
