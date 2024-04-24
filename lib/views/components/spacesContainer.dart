import 'package:flutter/material.dart';

class SpaceContainer extends StatelessWidget {
  final String txt;
  final String imageName;
  final VoidCallback onTapRemove;
  final VoidCallback onTapText;
  
  const SpaceContainer({
    Key? key,
    required this.txt,
    required this.imageName,
    required this.onTapRemove, required this.onTapText,
  }) : super(key: key);

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
            GestureDetector(
              onTap: onTapRemove, // Call onTapRemove when tapped
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: onTapText,
              child: Text(
                txt,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
