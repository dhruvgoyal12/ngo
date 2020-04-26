import 'package:flutter/material.dart';

class rounded_button extends StatelessWidget {
  rounded_button({
    @required this.onPressed,
    this.text,
    this.color,
  });
  final String text;
  final Function onPressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(32.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 400,
        height: 42.0,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
