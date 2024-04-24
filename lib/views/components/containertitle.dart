import 'package:flutter/material.dart';

class containertitle extends StatelessWidget {
  final String titlee;
  const containertitle({super.key, required this.titlee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 30, 10),
      child: Text(
        titlee,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl, // Set text direction to right-to-left
        style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 52, 168, 83),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
