import 'package:flutter/material.dart';

class addcontainer extends StatelessWidget {
  final String txt;
  final String imageName;
  const addcontainer({super.key, required this.txt, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('images/' + imageName),
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              txt,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
