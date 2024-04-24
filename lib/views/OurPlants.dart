import 'package:flutter/material.dart';
import 'package:mazratii/database/wheat.dart';
import 'package:mazratii/views/OurPlantsDetais.dart';
import 'package:mazratii/views/components/buttomnavbar.dart';
import 'package:mazratii/views/plantinfo.dart';

import 'components/plantcontainer.dart';
import '../database/Barley.dart';
import '../database/myStrawberry.dart';
import '../database/potato.dart';
import '../database/tomato.dart';

class OurPants extends StatefulWidget {
  OurPants();

  @override
  State<OurPants> createState() => _OurPlantsState();
}

class _OurPlantsState extends State<OurPants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 20, 8),
              child: Text(
                "النباتات",
                textAlign: TextAlign.right, // Align text to the right
                textDirection:
                    TextDirection.rtl, // Set text direction to right-to-left
                style: TextStyle(fontSize: 40, color: Colors.green),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    print(
                        "/////////////////////////////////////////////////////////////${myWheat.age}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OurPlantDetails(plant: myWheat)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'wheat.png',
                    plantName: 'القمح',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OurPlantDetails(plant: myWheat)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'wheat.png',
                    plantName: 'القمح',
                  ),
                ),
              ],
            ),
            Container(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OurPlantDetails(plant: myStrawberry)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'myStrawberryy.png',
                    plantName: 'فراولة',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OurPlantDetails(plant: myBarley)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'CHIIR.png',
                    plantName: 'شعير',
                  ),
                ),
              ],
            ),
            Container(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OurPlantDetails(plant: myPotato)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'potatoo.png',
                    plantName: 'بطاطا',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OurPlantDetails(plant: myTomato)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'tomatoo.png',
                    plantName: 'طماطم',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }
}
