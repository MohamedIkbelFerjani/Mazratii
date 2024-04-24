import 'package:flutter/material.dart';
import 'package:mazratii/database/Corn.dart';
import 'package:mazratii/database/wheat.dart';
import 'package:mazratii/views/components/buttomnavbar.dart';
import 'package:mazratii/views/plantinfo.dart';

import 'components/plantcontainer.dart';
import '../database/Barley.dart';
import '../database/myStrawberry.dart';
import '../database/potato.dart';
import '../database/tomato.dart';

class plantsview extends StatefulWidget {
  final String SpaceId;
  final String Spacename;
  const plantsview({required this.SpaceId, required this.Spacename});

  @override
  State<plantsview> createState() => _plantsState();
}

class _plantsState extends State<plantsview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: const Color.fromARGB(0, 76, 175, 79),
            ),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                          builder: (context) => plantInfo(
                              plant: myWheat,
                              SpaceId: widget.SpaceId,
                              Spacename: widget.Spacename)),
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
                          builder: (context) => plantInfo(
                              plant: myCorn,
                              SpaceId: widget.SpaceId,
                              Spacename: widget.Spacename)),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'corn.png',
                    plantName: 'الذرة',
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
                          builder: (context) => plantInfo(
                              plant: myStrawberry,
                              SpaceId: widget.SpaceId,
                              Spacename: widget.Spacename)),
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
                          builder: (context) => plantInfo(
                              plant: myBarley,
                              SpaceId: widget.SpaceId,
                              Spacename: widget.Spacename)),
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
                          builder: (context) => plantInfo(
                              plant: myPotato,
                              SpaceId: widget.SpaceId,
                              Spacename: widget.Spacename)),
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
                          builder: (context) => plantInfo(
                              plant: myTomato,
                              SpaceId: widget.SpaceId,
                              Spacename: widget.Spacename)),
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
