import 'package:flutter/material.dart';

class details extends StatelessWidget {
  final String plantName;
  final String plantImage;
  final String plantAge;
  const details(
      {super.key,
      required this.plantName,
      required this.plantImage,
      required this.plantAge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 242, 242),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // color of the shadow
            spreadRadius: 0.5, // spread radius
            blurRadius: 4, // blur radius
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'images/' + plantImage,
            height: 70,
          ),
          Column(
            children: [
              Text(plantAge),
              Text(
                plantName,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
