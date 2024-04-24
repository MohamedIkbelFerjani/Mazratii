import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mazratii/Models/Location.dart';
import 'package:mazratii/views/maps.dart';
import 'package:mazratii/views/spacesview.dart';
import 'package:provider/provider.dart';

import '../Models/plantmodel.dart';
import '../Models/spacesmodel.dart';
import 'components/buttomnavbar.dart';
import 'components/containertitle.dart';
import 'components/writecontainer.dart';
import '../controller/spacescontroller.dart';

class addSpacewithLocation extends StatefulWidget {
  final location lo; // Pass the Position object from the previous screen

  const addSpacewithLocation({super.key, required this.lo});

  @override
  State<addSpacewithLocation> createState() => _addSpacewithLocationeState();
}

class _addSpacewithLocationeState extends State<addSpacewithLocation> {
  bool _showChoices = false;
  bool _soilChoices = false;
  String _spacetype = "نوع المساحة";
  String _soiltype = "نوع التربة";
  final _nameController = TextEditingController();
  final SpaceController _spaceController = SpaceController();
  Space? space;
  bool _locationSelected = false;
  @override
  void initState() {
    super.initState();
    space = Space(type: "", name: ''); // Initialize the space object
  }

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
                    "اضافة \n مساحة",
                    textAlign: TextAlign.right, // Align text to the right
                    textDirection: TextDirection
                        .rtl, // Set text direction to right-to-left
                    style: TextStyle(fontSize: 40, color: Colors.green),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 25, 30, 10),
              child: Text(
                "اختار نوع المساحة",
                textAlign: TextAlign.right,
                textDirection:
                    TextDirection.rtl, // Set text direction to right-to-left
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 52, 168, 83),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showChoices = !_showChoices;
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
                  child: _showChoices
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _spacetype = 'الشرفة';
                                setState(() {
                                  _showChoices = !_showChoices;
                                });
                              },
                              child: Text(
                                'الشرفة',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _spacetype = 'حديقة المنزل';
                                setState(() {
                                  _showChoices = !_showChoices;
                                });
                              },
                              child: Text(
                                'حديقة المنزل',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _spacetype = 'حقل';
                                setState(() {
                                  _showChoices = !_showChoices;
                                });
                              },
                              child: Text(
                                'حقل',
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
                              _spacetype,
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
            containertitle(
              titlee: "اختار اسم المساحة",
            ),
            Container(height: 10),
            Center(
              child: Container(
                  width: 350,
                  padding: EdgeInsets.all(7),
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
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      // Apply the same style as hint text
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'اسم المساحة',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  )),
            ),
            Container(height: 10),
            Container(height: 10),
            containertitle(
              titlee: "الموقع",
            ),
            Container(height: 10),
            Center(
              child: Container(
                width: 350,
                padding: EdgeInsets.all(10),
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
                child: Text(
                  'تم اختيار الموقع',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(height: 10),
            Container(height: 30),
            Center(
              child: GestureDetector(
                onTap: () async {
                  String selectedSpaceType =
                      _spacetype; // Store the selected space type
                  String spaceName =
                      _nameController.text; // Store the entered space name
                  if (selectedSpaceType == "نوع المساحة" || spaceName.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("يجب ملء البيانات"),
                          content: Text("الرجاء ملئ جميع البيانات."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("حسنًا"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    space?.name = spaceName;
                    space?.type = _spacetype;
                    await SpaceController.addSpacewithlocation(
                        space, widget.lo);
                    setState(() {
                      _spacetype =
                          selectedSpaceType; // Update _spacetype only after successful validation
                    });
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "spacesview", (route) => false);
                  }
                },
                child: Container(
                  width: 350,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 168, 83),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 4,
                        offset: Offset(0, 4),
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }
}
