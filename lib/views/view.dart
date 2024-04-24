import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mazratii/Models/taskmodel.dart';
import 'package:mazratii/database/myStrawberry.dart';
import 'package:mazratii/database/potato.dart';
import 'package:mazratii/database/tomato.dart';
import 'package:mazratii/views/addtask.dart';
import 'package:mazratii/views/plantinfo.dart';
import 'package:mazratii/views/plants.dart';

import '../database/Barley.dart';
import 'components/add.dart';
import 'components/buttomnavbar.dart';
import 'components/plantview.dart';

class SpaceDetailView extends StatefulWidget {
  final QueryDocumentSnapshot spaceDocument;

  SpaceDetailView({required this.spaceDocument});

  @override
  _SpaceDetailViewState createState() => _SpaceDetailViewState();
}

class _SpaceDetailViewState extends State<SpaceDetailView> {
  int calculateDaysBetweenAndAdd(
      Timestamp firstDate, DateTime secondDate, int number) {
    int differenceInDays =
        (secondDate.difference(firstDate.toDate()).inDays).abs();
    int totalDays = differenceInDays + number;
    return totalDays;
  }

  List<QueryDocumentSnapshot> plants = [];
  List<QueryDocumentSnapshot> tasks = [];

  Future<void> getSpaces() async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        // Get the reference to the space document
        DocumentReference spaceRef = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('spaces')
            .doc(widget.spaceDocument.id);

        // Query the plants subcollection
        QuerySnapshot plantsSnapshot =
            await spaceRef.collection('plants').get();
        QuerySnapshot tasksSnapshot = await spaceRef.collection('tasks').get();

        setState(() {
          // Assuming 'plants' is a List<DocumentSnapshot>
          // If it's not, adjust accordingly
          plants = plantsSnapshot.docs;
          tasks = tasksSnapshot.docs;
        });
      } else {
        // If the user is not logged in, handle this case
        setState(() {
          plants =
              []; // Set plants to an empty list or handle it according to your requirements
          tasks =
              []; // Set plants to an empty list or handle it according to your requirements
        });
      }
    } catch (error) {
      // Properly handle errors
      print("Error getting spaces: $error");
      // You might want to show an error message to the user here
      // or handle the error in some other way
    }
  }

  void _removeSpace(BuildContext context, QueryDocumentSnapshot<Object?> task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(task['name']),
          ),
          content: Text(task['description']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Dismiss the dialog and return false
              },
              child: Text('تم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Dismiss the dialog and return true
              },
              child: Text('مازال'),
            ),
          ],
        );
      },
    ).then((confirmed) async {
      if (confirmed != null && confirmed) {
        DocumentReference docRef = task.reference;
        docRef.update({'completed': true});
        getSpaces();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        getSpaces();
      }
    });
  }

  final List<String> choices = ['النباتات', 'المهام'];
  List<bool> isSelected = [true, false]; // Initialize isSelected list
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spaceDocument['name']),
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            padding: EdgeInsets.all(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                image: AssetImage(
                    _getImageNameSpace(widget.spaceDocument['spacetype'])),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    widget.spaceDocument['name'],
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
          Container(
            height: 10,
          ),
          ToggleButtons(
            children: choices
                .map((choice) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(choice),
                    ))
                .toList(),
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
                selectedIndex = index;
              });
            },
            isSelected: isSelected,
            selectedColor: const Color.fromARGB(
                255, 255, 255, 255), // Color when button is selected
            color: Colors.black, // Color when button is not selected
            fillColor: Colors.green, // Background color when button is selected
            borderRadius: BorderRadius.circular(10), // Border radius of buttons
            borderWidth: 2, // Border width of buttons
            selectedBorderColor:
                Colors.green, // Border color of selected button
            splashColor: Colors.green
                .withOpacity(0.5), // Splash color when button is tapped
            highlightColor: Colors.green
                .withOpacity(0.2), // Highlight color when button is tapped
            textStyle: TextStyle(fontSize: 24), // Text style of buttons
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                if (selectedIndex == 0) ...[
                  for (var i = 0; i < plants.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        // // Navigate to the SpaceDetailView and pass the space document
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           SpaceDetailView(spaceDocument: plants[i])),
                        // );
                        // DocumentReference docRef = plants[i].reference;
                        // docRef.update({'description': 'hello'});
                      },
                      child: plantview(
                        txt: plants[i][
                            'name'], // Assuming 'name' is the field containing the space name
                        imageName: _getImageName(plants[i]['name']),
                        days: daysUntilInputTime(plants[i]['time']),
                      ),
                    ),

                    SizedBox(height: 10), // Add a container with height 10
                  ],
                  GestureDetector(
                      onTap: () {
                        // Navigate to the SpaceDetailView and pass the space document
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => plantsview(
                                    SpaceId: widget.spaceDocument.id,
                                    Spacename: widget.spaceDocument['name'],
                                  )),
                        );
                      },
                      child: addcontainer(
                          txt: 'اضافة نبتة', imageName: _getImageName(""))),
                ] else ...[
                  // Content for المهام
                  // Container(
                  //   padding: EdgeInsets.all(20),
                  //   child: Text(
                  //     'المهام content goes here',
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  for (var i = 0; i < tasks.length; i++) ...[
                    if (Check_the_tasktodayornot(tasks[i], plants)) ...[
                      GestureDetector(
                        // onTap: () {
                        //   // Navigate to the SpaceDetailView and pass the space document
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             SpaceDetailView(spaceDocument: plants[i])),
                        //   );
                        // },
                        onTap: () => _removeSpace(context, tasks[i]),
                        child: plantview(
                          txt: tasks[i][
                              'name'], // Assuming 'name' is the field containing the space name
                          imageName: _getImageName(tasks[i]['plantName']),
                          days: 0,
                        ),
                      ),
                      SizedBox(height: 10), // Add a container with height 10
                    ],
                  ],
                  GestureDetector(
                      onTap: () {
                        // Navigate to the SpaceDetailView and pass the space document
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addtask()),
                        );
                      },
                      child: addcontainer(
                          txt: 'اضافة مهمة', imageName: _getImageName(""))),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }

  int daysUntilInputTime(Timestamp inputTimestamp) {
    DateTime inputTime =
        inputTimestamp.toDate(); // Convert Timestamp to DateTime
    DateTime currentTime = DateTime.now();

    // Calculate the difference in days
    Duration difference = inputTime.difference(currentTime);
    int daysDifference = difference.inDays;

    return daysDifference;
  }

  bool Check_the_tasktodayornot(
      QueryDocumentSnapshot task, List<QueryDocumentSnapshot> plants) {
    String taskId = task["plantId"];

    //// For Tasks that been added Alone
    if (taskId == "") {
      DateTime taskday = task["date"].toDate();
      DateTime today = DateTime.now();
      DateTime taskDate = DateTime(taskday.year, taskday.month, taskday.day);
      DateTime currentDate = DateTime(today.year, today.month, today.day);
      print("WAAAAAAAAAAAAAAAAAAAAYWAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
// Comparing the dates
      bool isSameDay = taskDate == currentDate && task["completed"] == false;
      if (isSameDay) {
        return true;
      } else {
        return false;
      }
    } else {
      //// it can have task from add tasks and without plant
      if (plants.isEmpty) {
        return false;
      } else {
        var plant = plants.firstWhere((plant) => plant.id == taskId);
        print(
            './///////////////////////////:TASK DAY ====${task['day']}//////and ${calculateDaysBetweenAndAdd(plant['time'], DateTime.now(), plant['ageofplant'])}');
        if (task['day'] ==
            calculateDaysBetweenAndAdd(
                plant['time'], DateTime.now(), plant['ageofplant'])) {
          return true;
        } else {
          print(
              './///////////////////////////:TASK DAY ====${task['day']}//////and ${calculateDaysBetweenAndAdd(plant['time'], DateTime.now(), plant['ageofplant'])}');
          return false;
        }
      }
    }
  }

  int extractDayFromDate(DateTime dateTime) {
    return dateTime.day;
  }

  String _getImageName(String spacetype) {
    // Map spacetype to corresponding image name
    switch (spacetype) {
      case 'نبتة الطماطم':
        return 'tomatoo.jpeg';
      case 'نبتة القمح':
        return 'wheatt.jpg';
      case 'نبات الذرة':
        return 'Cornn.jpg';
      case 'نبتة الفراولة':
        return 'strw.jpg';

      case 'نبتة الشعير':
        return 'Chiiir.jpeg';

      case 'نبتة البطاطا':
        return 'potatoo.jpeg';
      default:
        return 'henchir.jpeg';
    }
  }

  String _getImageNameSpace(String spacetype) {
    // Map spacetype to corresponding image name
    switch (spacetype) {
      case 'الشرفة':
        return 'images/chorfa.jpeg';
      case 'حديقة المنزل':
        return 'images/Garden.jpeg';
      default:
        return 'images/henchir.jpeg';
    }
  }
}
