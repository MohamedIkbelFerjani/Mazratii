import 'package:flutter/material.dart';
import 'package:mazratii/views/Scan.dart';
import 'package:mazratii/views/components/hidden_drawer.dart';

class buttomnavbar extends StatelessWidget {
  const buttomnavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'images/farms.png',
            width: 24,
            height: 24,
          ),
          label: 'Spaces',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'images/scan.png',
            width: 24,
            height: 24,
          ),
          label: 'Search',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: const Color.fromARGB(255, 52, 168, 83),
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HidenDrawer(initPositionSelected: 0),
              ),
            );
            break;
          case 1:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HidenDrawer(initPositionSelected: 1),
              ),
            );
            break;
          case 2:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ScanView(),
              ),
            );
            break;
        }
      },
    );
  }
}
