import 'package:flutter/material.dart';

class addbutton extends StatelessWidget {
  const addbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Container(
                width: 350,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 52, 168, 83),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.withOpacity(0.5), // color of the shadow
                      spreadRadius: 0.5, // spread radius
                      blurRadius: 4, // blur radius
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "اضافة",
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
  }
}