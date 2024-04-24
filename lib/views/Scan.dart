import 'package:flutter/material.dart';
import 'package:mazratii/views/ai.dart';
import 'package:mazratii/views/components/buttomnavbar.dart';
import 'package:mazratii/views/plantinfo.dart';

import 'components/plantcontainer.dart';
import '../database/Barley.dart';
import '../database/myStrawberry.dart';
import '../database/potato.dart';
import '../database/tomato.dart';

class ScanView extends StatefulWidget {
  const ScanView();

  @override
  State<ScanView> createState() => _plantsState();
}

class _plantsState extends State<ScanView> {
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
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('Firstpageever', (route) => false);
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
                // GestureDetector(
                //   onTap: () {
                //     print(
                //         "/////////////////////////////////////////////////////////////${myOliveTree.age}");
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AI(
                //                 model: '',
                //                 label: '',
                //               )),
                //     );
                //   },
                //   child: plantcontainer(
                //     plantAge: '',
                //     plantImage: 'olive.png',
                //     plantName: 'الزيتون',
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => AI(
                //                 model: '',
                //                 label: '',
                //               )),
                //     );
                //   },
                //   child: plantcontainer(
                //     plantAge: ' ',
                //     plantImage: 'fig.png',
                //     plantName: 'التين',
                //   ),
                // ),
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
                          builder: (context) => AI(
                                model: 'images/modelstrw.tflite',
                                label: 'images/labelstrw.txt',
                              )),
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
                        builder: (context) => AI(
                          model: 'images/modelpotato.tflite',
                          label: 'images/labelspotato.txt',
                        ),
                      ),
                    );
                  },
                  child: plantcontainer(
                    plantAge: '',
                    plantImage: 'pepper.png',
                    plantName: 'فلفل',
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
                          builder: (context) => AI(
                                model: 'images/modelpotato.tflite',
                                label: 'images/labelspotato.txt',
                              )),
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
                          builder: (context) => AI(
                                model: 'images/modelpotato.tflite',
                                label: 'images/labelspotato.txt',
                              )),
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
