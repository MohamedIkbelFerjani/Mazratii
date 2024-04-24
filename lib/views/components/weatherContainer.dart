import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class weathercontainer extends StatelessWidget {
  final String weatherr;
  final String? city;
  final String degree;
  final String icon;
  const weathercontainer(
      {super.key,
      required this.weatherr,
      required this.city,
      required this.degree,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 180,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 7), // Offset in x and y direction
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Lottie.asset(
                icon,
                width: 200, // specify the desired width
                height: 200, // specify the desired height
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20.0), // Adjust the left padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      degree,
                      style: TextStyle(
                          color: Color.fromARGB(255, 64, 160, 255),
                          fontSize: 40),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        city!,
                        style: TextStyle(
                            color: Color.fromARGB(255, 120, 120, 120),
                            fontSize: 15),
                      ),
                      Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 255, 17, 0),
                        size: 18,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      weatherr,
                      style: TextStyle(
                          color: Color.fromARGB(255, 63, 63, 63), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
