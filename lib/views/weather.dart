import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:lottie/lottie.dart';
import 'package:mazratii/controller/spacescontroller.dart';
import 'package:mazratii/controller/weatherController.dart';
import 'package:mazratii/controller/weatherservice.dart';
import 'package:mazratii/Models/weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/weatherContainer.dart';

class WetherView extends StatefulWidget {
  const WetherView({Key? key}) : super(key: key);

  @override
  State<WetherView> createState() => _WetherViewState();
}

class _WetherViewState extends State<WetherView> {
  List<QueryDocumentSnapshot> spaces = [];

  final SpaceController _spacesController = SpaceController();
  Future<void> _fetchSpaces() async {
    List<QueryDocumentSnapshot> fetchedSpaces =
        await _spacesController.getSpaces();
    setState(() {
      spaces = fetchedSpaces;
    });
  }

  final _weatherService = WeatherService("6c407a5564eccf64b767618f5577a987");
  Weatherr? _weather;
  String? city = "";
  List<Weatherr> _spaceWeathers = [];

  // Fetch weather for spaces
  Future<void> fetchSpacesWeather() async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      QuerySnapshot spacesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('spaces')
          .get();

      List<Weatherr> spaceWeathers = [];

      for (QueryDocumentSnapshot doc in spacesSnapshot.docs) {
        double latitude;
        double longitude;
        try {
          latitude = double.parse(doc['latitude'].toString());
          longitude = double.parse(doc['longitude'].toString());
        } catch (e) {
          print('Error parsing latitude or longitude for space ${doc.id}: $e');
          continue;
        }

        // Get weather for each space
        Weatherr spaceWeather =
            await _weatherService.getWeather(latitude, longitude);
        spaceWeathers.add(spaceWeather);
      }

      setState(() {
        _spaceWeathers = spaceWeathers;
      });
    } catch (error) {
      print("Failed to fetch spaces weather: $error");
    }
  }

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

  @override
  void initState() {
    super.initState();
    _fetchSpaces();
    fetchSpacesWeather();
    fetchCurrentLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 18, 32, 18),
            child: Text(
              'حالة الطقس في مكانك الحالي',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          weathercontainer(
            weatherr:
                WeatherController().getWeatherinArabic(_weather?.mainCondition),
            city: city,
            degree: '${_weather?.temperature.round() ?? ""}℃',
            icon: WeatherController()
                .getWeatherAnimation(_weather?.mainCondition),
          ),
          Divider(),

          // Spaces weather
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 18, 32, 18),
            child: Text(
              'حالة الطقس في مساحاتك',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _spaceWeathers.length,
              itemBuilder: (context, index) {
                final spaceWeather = _spaceWeathers[index];
                // return ListTile(
                //   title: Text(spaces[index]['name']),
                //   subtitle: Text(
                //       '${spaceWeather.temperature.round()}℃ and ${getWeatherinArabic(spaceWeather.mainCondition)}'),
                // );
                return Column(
                  children: [
                    weathercontainer(
                      city: spaces[index]['name'],
                      degree: '${spaceWeather.temperature.round()}℃',
                      icon: WeatherController()
                          .getWeatherAnimation(spaceWeather.mainCondition),
                      weatherr: WeatherController()
                          .getWeatherinArabic(spaceWeather.mainCondition),
                    ),
                    SizedBox(height: 20), // Adjust the height as needed
                  ],
                );
              },
            ),
          ),
          // Lottie.asset(
          //   getWeatherAnimation(_weather?.mainCondition),
          //   width: 200, // specify the desired width
          //   height: 200, // specify the desired height
          // ),
          // weathercontainer(
          //   weatherr:
          //       WeatherController().getWeatherinArabic(_weather?.mainCondition),
          //   city: city,
          //   degree: '${_weather?.temperature.round() ?? ""}℃',
          //   icon: WeatherController()
          //       .getWeatherAnimation(_weather?.mainCondition),
          // )
        ],
      ),
    );
  }
}
