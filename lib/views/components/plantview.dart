import 'package:flutter/material.dart';

class plantview extends StatelessWidget {
  final String txt;
  final int days;
  final String imageName;
  const plantview(
      {super.key,
      required this.txt,
      required this.imageName,
      required this.days});

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
              color: Color.fromARGB(0, 255, 255, 255),
            ),
            Column(
              children: [
                Text(
                  txt,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  ' منذ $days يوم',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
