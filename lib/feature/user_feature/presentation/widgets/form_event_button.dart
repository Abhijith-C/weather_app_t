import 'package:flutter/material.dart';

class FormEventButton extends StatelessWidget {
  VoidCallback onTap;
  String title;
  Color? backgroundColor;
  FormEventButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        onPressed: onTap,
        child: Text(title));
  }
}
