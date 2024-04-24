import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mazratii/views/components/buttomnavbar.dart';
import 'package:mazratii/controller/spacescontroller.dart';

import 'components/add.dart';
import 'components/plantcontainer.dart';
import 'components/spacesContainer.dart';
import 'addspace.dart';
import 'view.dart';

class SpacesView extends StatefulWidget {
  const SpacesView({Key? key}) : super(key: key);

  @override
  State<SpacesView> createState() => _SpacesViewState();
}

class _SpacesViewState extends State<SpacesView> {
  final SpaceController _spacesController = SpaceController();

  List<QueryDocumentSnapshot> spaces = [];
  void _removeSpace(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تأكيد الحذف'),
          ),
          content: Text('هل أنت متأكد أنك تريد حذف هذه المساحة؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Dismiss the dialog and return false
              },
              child: Text('حذف'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Dismiss the dialog and return true
              },
              child: Text('تراجع'),
            ),
          ],
        );
      },
    ).then((confirmed) async {
      if (confirmed != null && confirmed) {
        // If user confirmed deletion, proceed with deletion
        await _spacesController.deleteSpace(index);
        _fetchSpaces(); // Refresh spaces after deletion
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSpaces();
  }

  Future<void> _fetchSpaces() async {
    List<QueryDocumentSnapshot> fetchedSpaces =
        await _spacesController.getSpaces();
    setState(() {
      spaces = fetchedSpaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
              child: Text(
                "مساحاتك",
                textAlign: TextAlign.right, // Align text to the right
                textDirection:
                    TextDirection.rtl, // Set text direction to right-to-left
                style: TextStyle(fontSize: 40, color: Colors.green),
              ),
            ),
            // Display spaces inside addcontainer widgets
            for (var i = 0; i < spaces.length; i++) ...[
              GestureDetector(
                onTap: () {
                  // Navigate to the SpaceDetailView and pass the space document
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SpaceDetailView(spaceDocument: spaces[i])),
                  );
                },
                child: SpaceContainer(
                  txt: spaces[i]['name'],
                  imageName: _getImageName(spaces[i]['spacetype']),
                  onTapRemove: () =>
                      _removeSpace(context, i), // Pass context and index
                  onTapText: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SpaceDetailView(spaceDocument: spaces[i])),
                    );
                  }, // Call _removeSpace when tapped
                ),
              ),
              SizedBox(height: 10), // Add a container with height 10
            ],
            // Add container for adding space
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addSpace()),
                );
              },
              child: addcontainer(
                txt: 'اضافة مساحة',
                imageName: 'add.png',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }

  String _getImageName(String spacetype) {
    // Map spacetype to corresponding image name
    switch (spacetype) {
      case 'الشرفة':
        return 'chorfa.jpeg';
      case 'حديقة المنزل':
        return 'Garden.jpeg';
      default:
        return 'henchir.jpeg';
    }
  }
}
