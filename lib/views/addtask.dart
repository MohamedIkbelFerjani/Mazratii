import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mazratii/Models/sch.dart';
import 'package:mazratii/controller/taskcontroller.dart';
import 'package:mazratii/views/components/addbutton.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datatTimePicker;
import 'package:mazratii/views/notificationservice.dart';
import 'components/buttomnavbar.dart';
import 'components/containertitle.dart';
import 'components/hidden_drawer.dart';
import 'components/writecontainer.dart';
import '../controller/spacescontroller.dart';

class addtask extends StatefulWidget {
  const addtask({super.key});

  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  DateTime now = DateTime.now();
  List<QueryDocumentSnapshot> spaces = [];
  DateTime scheduleTime = DateTime.now();
  final SpaceController _spacesController = SpaceController();

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

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Function to select date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ??
          TimeOfDay
              .now(), // Use selectedTime if available, else use current time
    );
    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  final GlobalKey<WriteContainerState> _writeContainerKey = GlobalKey();
  bool _showChoices = false;
  bool _soilChoices = false;
  bool _plantChoices = false;
  String _tasktype = "نوع المهمة";
  String _spacename = "اسم المساحة";
  String _planttype = "اسم النبتة";
  String? spaceid;
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
              color: Color.fromARGB(0, 0, 0, 0),
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
            Navigator.of(context)
                .pushNamedAndRemoveUntil("Firstpageever", (route) => false);
          },
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    radius: 60,
                    child: ClipOval(
                      child: Image.asset(
                        "images/addtask.jpeg",
                        width: 150,
                      ),
                    ),
                  ),
                ),
                Container(width: 100),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
                  child: Text(
                    "اضافة \n مهمة",
                    textAlign: TextAlign.right, // Align text to the right
                    textDirection: TextDirection
                        .rtl, // Set text direction to right-to-left
                    style: TextStyle(fontSize: 40, color: Colors.green),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            containertitle(
              titlee: "اختار اسم المهمة",
            ),
            Container(height: 10),
            WriteContainer(
              key: _writeContainerKey,
              hintText: 'اسم المهمة',
            ),
            Container(height: 10),
            containertitle(titlee: "اختار المساحة "),
            Container(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _soilChoices = !_soilChoices;
                  });
                },
                child: Container(
                  width: 350,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 242, 242, 242),
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
                  child: _soilChoices
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (var space in spaces)
                              InkWell(
                                onTap: () {
                                  _spacename = space['name'];
                                  spaceid = space.id;
                                  setState(() {
                                    _soilChoices = !_soilChoices;
                                  });
                                },
                                child: Text(
                                  space['name'],
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.arrow_drop_down,
                              size: 36,
                              color: Colors.grey,
                            ),
                            Text(
                              _spacename,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            Container(height: 10),
            containertitle(titlee: "اختار موعدة المهمة "),
            Container(height: 10),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            //   child: Container(
            //     width: 350,
            //     padding: EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 242, 242, 242),
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color:
            //               Colors.grey.withOpacity(0.5), // color of the shadow
            //           spreadRadius: 0.5, // spread radius
            //           blurRadius: 4, // blur radius
            //           offset: Offset(0, 4), // changes position of shadow
            //         ),
            //       ],
            //     ),
            //     child: GestureDetector(
            //       onTap: () => _selectDate(context),
            //       child: Text(
            //         selectedDate != null
            //             ? '${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}'
            //             : 'اختر اليوم',
            //         textAlign: TextAlign.right,
            //         textDirection: TextDirection.rtl,
            //         style: TextStyle(
            //           fontSize: 20,
            //           color: selectedDate != null ? Colors.grey : Colors.grey,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            DatePickerTxt(onDateSelected: (date) {
              setState(() {
                scheduleTime = date;
              });
            }),
            // containertitle(titlee: "اختار الساعة "),
            // Container(height: 10),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            //   child: Container(
            //     width: 350,
            //     padding: EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 242, 242, 242),
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color:
            //               Colors.grey.withOpacity(0.5), // color of the shadow
            //           spreadRadius: 0.5, // spread radius
            //           blurRadius: 4, // blur radius
            //           offset: Offset(0, 4), // changes position of shadow
            //         ),
            //       ],
            //     ),
            //     child: GestureDetector(
            //       onTap: () => _selectTime(context), // Use _selectTime method
            //       child: Text(
            //         selectedTime != null
            //             ? '${selectedTime!.hour}:${selectedTime!.minute}'
            //             : 'اختار الساعة',
            //         textAlign: TextAlign.right,
            //         textDirection: TextDirection.rtl,
            //         style: TextStyle(
            //           fontSize: 20,
            //           color: selectedTime != null ? Colors.grey : Colors.grey,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Container(height: 30),
            GestureDetector(
                onTap: () {
                  String writtenText =
                      _writeContainerKey.currentState!.writtenText;
                  taskcontroller.addTask(
                    spaceid,
                    scheduleTime,
                    _spacename,
                    writtenText,
                  );
                  NotificationServices.scheduleNotification(
                    schedule: sch(details: writtenText, time: scheduleTime),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HidenDrawer(
                              initPositionSelected: 0,
                            )),
                  );
                },
                child: addbutton()),
            Container(
              height: 10,
            )
          ],
        ),
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DatePickerTxt({
    Key? key,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  DateTime? scheduleTime; // Define scheduleTime at the class level

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
        child: Container(
          width: 350,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 242, 242, 242),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // color of the shadow
                spreadRadius: 0.5, // spread radius
                blurRadius: 4, // blur radius
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              datatTimePicker.DatePicker.showDateTimePicker(
                context,
                showTitleActions: true,
                onChanged: (date) {
                  setState(() {
                    scheduleTime =
                        date; // Update scheduleTime when the date changes
                  });
                },
                onConfirm: (date) {
                  widget.onDateSelected(
                      date); // Pass selected date to the parent widget
                },
              );
            },
            child: Text(
              scheduleTime != null
                  ? '${scheduleTime!.year}/${scheduleTime!.month}/${scheduleTime!.day} الساعة ${scheduleTime!.hour}:${scheduleTime!.minute}'
                  : 'موعدة المهمة',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
