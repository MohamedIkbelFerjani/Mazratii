import 'package:flutter/material.dart';
import 'package:mazratii/Models/plantmodel.dart';
import 'package:mazratii/controller/plantscontroller.dart';
import 'package:mazratii/views/NotificationService.dart';
import 'package:mazratii/views/components/buttomnavbar.dart';
import 'package:mazratii/views/components/details.dart';
import 'package:mazratii/controller/spacescontroller.dart';
import 'package:mazratii/views/spacesview.dart';
import '../Models/sch.dart';
import '../Models/taskmodel.dart';
import 'components/addbutton.dart';
import 'components/containertitle.dart';
import 'components/plantcontainer.dart';

class plantInfo extends StatefulWidget {
  final Plant plant;
  final String SpaceId;
  final String Spacename;
  const plantInfo(
      {super.key,
      required this.plant,
      required this.SpaceId,
      required this.Spacename});

  @override
  State<plantInfo> createState() => _plantInfoState();
}

class _plantInfoState extends State<plantInfo> {
  // Future<void> _showAgeInputDialog() async {
  //   int? plantAge;
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Enter Plant Age'),
  //         content: TextField(
  //           controller: _ageController,
  //           // keyboardType: TextInputType.number,
  //           decoration: InputDecoration(labelText: 'Age'),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               plantAge = int.tryParse(_ageController.text);
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   if (plantAge != null) {
  //     setState(() {
  //       widget.plant.age = plantAge!;
  //     });
  //   }
  // }
  DateTime now = DateTime.now();
  bool _isLoading = false;
  final _ageController = TextEditingController();

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
              color: const Color.fromARGB(0, 255, 255, 255),
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: Image.asset(
                            "images/${widget.plant.image}",
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 100),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
                      child: Text(
                        "${widget.plant.plantName}",
                        textAlign: TextAlign.right, // Align text to the right
                        textDirection: TextDirection
                            .rtl, // Set text direction to right-to-left
                        style: TextStyle(fontSize: 35, color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              containertitle(
                titlee: 'أهم المعلومات',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  details(
                    plantAge: 'الحاجيات المائية',
                    plantImage: 'water.png',
                    plantName: widget.plant.water,
                  ),
                  details(
                    plantAge: 'مدة النمو',
                    plantImage: 'Time.png',
                    plantName: widget.plant.Duration_of_growth,
                  ),
                  details(
                    plantAge: 'فصل  الزراعة',
                    plantImage: 'weather.png',
                    plantName: widget.plant.season,
                  ),
                ],
              ),
              containertitle(
                titlee: 'المعلومات العامة',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.plant.description,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection
                            .rtl, // Set text direction to right-to-left
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      containertitle(
                        titlee: 'عمر نبتتك',
                      ),
                      Center(
                        child: Container(
                          width: 350,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 242, 242, 242),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // color of the shadow
                                spreadRadius: 0.5, // spread radius
                                blurRadius: 4, // blur radius
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _ageController,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              // Apply the same style as hint text
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'عمر النبتة',
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () async {
                        // await _showAgeInputDialog();

                        // Get the age from the text controller
                        int plantAge = int.tryParse(_ageController.text) ?? 1;
                        List<Tasks> filteredTasks = widget.plant.tasks
                            .where((task) => task.day >= plantAge)
                            .toList();
                        // Set the age of the plant
                        for (Tasks task in filteredTasks) {
                          NotificationServices.scheduleNotification(
                            schedule: sch(
                              details: task.name,
                              time: now.add(Duration(days: task.day)),
                            ),
                          );
                          print("///////////////${task.name}");
                        }
                        ;
                        widget.plant.age = plantAge;
                        setState(() {
                          widget.plant.tasks = filteredTasks;

                          _isLoading = true;
                        });
                        await PlantController.addPlant(
                            widget.SpaceId, widget.plant, widget.Spacename);
                        Navigator.pop(context);
                      },
                      child: addbutton(),
                    ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }
}
