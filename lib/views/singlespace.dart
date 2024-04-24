import 'package:flutter/material.dart';

import '../views/components/appbar.dart';
import '../views/components/buttomnavbar.dart';

class singlespace extends StatefulWidget {
  const singlespace({super.key});

  @override
  State<singlespace> createState() => _singlespaceState();
}

class _singlespaceState extends State<singlespace> {
  final List<String> choices = ['النباتات', 'المهام'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            padding: EdgeInsets.all(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                image: AssetImage('images/chorfa.jpeg'),
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "الشرفة",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ],
            ),
          ),
          Center(
            child: ToggleButtons(
              children: choices
                  .map((choice) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(choice),
                      ))
                  .toList(),
              onPressed: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              isSelected:
                  List.generate(choices.length, (i) => selectedIndex == i),
            ),
          )
        ],
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }
}
