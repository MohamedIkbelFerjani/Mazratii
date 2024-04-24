import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mazratii/Models/weather.dart';
import 'package:mazratii/controller/weatherController.dart';
import 'package:mazratii/controller/weatherservice.dart';
import 'package:mazratii/views/addspace.dart';
import 'package:mazratii/views/components/hidden_drawer.dart';
import 'package:mazratii/views/maps.dart';

import '../controller/usercontroller.dart';
import 'addtask.dart';
import 'components/add.dart';
import 'components/buttomnavbar.dart';
import 'components/weatherContainer.dart';

class Firstpageever extends StatefulWidget {
  const Firstpageever({super.key});

  @override
  State<Firstpageever> createState() => _FirstpageeverState();
}

class _FirstpageeverState extends State<Firstpageever> {
  // Fetch current location weather
  Future<void> fetchCurrentLocationWeather() async {
    try {
      Position position = await _weatherService.getCurrentPostion();
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(
          position.latitude, position.longitude);
      setState(() {
        _weather = weather;
        city = cityName;
      });
    } catch (e) {
      print("Failed to fetch current location weather: $e");
    }
  }

  final _weatherService = WeatherService("6c407a5564eccf64b767618f5577a987");
  Weatherr? _weather;
  String? city = "";
  // Create an instance of UserController

  String? username;

  @override
  void initState() {
    super.initState();
    getUserName();
    fetchCurrentLocationWeather();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.menu,
      //         color: Colors.green,
      //       ), // Change this to the icon you want
      //       onPressed: () {
      //         // Add your action here
      //       },
      //     ),
      //   ], // Change this to the icon you want
      // ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.asset(
                    "images/Hello.jpeg",
                    width: 100,
                  ),
                ),
              ),
            ),
            Container(width: 100),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
                child: Text(
                  "أهلا \n ,$username ",
                  textAlign: TextAlign.right, // Align text to the right
                  textDirection:
                      TextDirection.rtl, // Set text direction to right-to-left
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        weathercontainer(
          weatherr:
              WeatherController().getWeatherinArabic(_weather?.mainCondition),
          city: city,
          degree: '${_weather?.temperature.round() ?? ""}℃',
          icon:
              WeatherController().getWeatherAnimation(_weather?.mainCondition),
        ),
        Container(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 30, 10),
          child: Text(
            "المساحات",
            textAlign: TextAlign.right,
            textDirection:
                TextDirection.rtl, // Set text direction to right-to-left
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 52, 168, 83),
                fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addSpace()),
              );
            },
            child: Container(
              width: 350,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('images/add.png'),
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "اضافة مساحة",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 30, 10),
          child: Text(
            "المهام",
            textAlign: TextAlign.right,
            textDirection:
                TextDirection.rtl, // Set text direction to right-to-left
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 52, 168, 83),
                fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => addtask()));
          },
          child: addcontainer(
            txt: 'اضافة مهمة',
            imageName: 'add.png',
          ),
        )
      ]),
      bottomNavigationBar: buttomnavbar(),
    );
    return scaffold;
  }
}
