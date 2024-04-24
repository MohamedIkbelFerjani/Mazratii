import 'package:flutter/material.dart';

class aa extends StatelessWidget {
  const aa({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.green,
          ), // Change this to the icon you want
          onPressed: () {
            // Add your action here
          },
        ),
      ], // Change this to the icon you want
    );
  }
}
