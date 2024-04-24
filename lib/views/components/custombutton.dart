import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const Custombutton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.green,
      textColor: Colors.white,
      child: Text(title),
    );
  }
}
