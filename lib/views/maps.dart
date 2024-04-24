import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../Models/Location.dart';
import 'addspacewithposition.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();
  Marker _userLocationMarker = Marker(markerId: MarkerId('userLocation'));
  List<Marker> _markers = []; // List to hold markers
  final String mapTypeButtonHeroTag = 'mapTypeButton';
  final String locationButtonHeroTag = 'locationButton';

  // Fetch spaces from Firestore
  Future<void> fetchSpaces() async {  
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      QuerySnapshot spacesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('spaces')
          .get();

      print(
          "Number of spaces retrieved from Firebase: ${spacesSnapshot.docs.length}");

      List<Marker> markers = [];

      spacesSnapshot.docs.forEach((doc) {
        // Parse latitude and longitude from string to double
        double latitude;
        double longitude;
        try {
          latitude = double.parse(doc['latitude'].toString());
          longitude = double.parse(doc['longitude'].toString());
        } catch (e) {
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%::");

          print('Error parsing latitude or longitude for marker ${doc.id}: $e');
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%::");

          return; // Skip this marker if parsing fails
        }
        String name =
            doc['name'] ?? 'Unknown'; // Provide a default value if name is null

        Marker marker = Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              title: name,
            ));
        markers.add(marker);
      });

      setState(() {
        _markers = markers;
      });

      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%::");
      print("Markers retrieved from Firebase: ${_markers.length}");
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%::");
    } catch (error) {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%::");
      print("Failed to fetch spaces: $error");
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%::");
    }
  }

  getCurrentLocationApp() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
      }
    }
    if (permission == LocationPermission.whileInUse) {
      print('Location permission granted');
    }
  }

  @override
  void initState() {
    getCurrentLocationApp();
    fetchSpaces();
    super.initState();
  }

  MapType _currentMapType = MapType.normal;

  void _toggleMapType() {
    setState(() {
      _currentMapType = (_currentMapType == MapType.normal)
          ? MapType.satellite
          : MapType.normal;
    });
  }

  // Function to add marker
  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          _showAddSpaceDialog(position);
        },
      ));
    });
  }

  Future<void> _showAddSpaceDialog(LatLng position) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('اضافة مساحة'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text('هل تريد اضافة مساحة')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                _addSpaceWithLocation(position);
              },
            ),
          ],
        );
      },
    );
  }

  void _addSpaceWithLocation(LatLng position) {
    // Navigate to a new page or perform any action here
    // Pass the location to your addSpacewithLocation function
    final newLocation =
        location(latitude: position.latitude, longitude: position.longitude);

    // Call the function with the location
    // addSpacewithLocation(lo: newLocation);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => addSpacewithLocation(
                lo: newLocation,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(36.8065, 10.1815),
                zoom: 7,
              ),
              mapType: _currentMapType,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set.of([_userLocationMarker, ..._markers]),
              /// In googleMap onTap directly Get the postion  
              onTap: _addMarker,
            ),
            Positioned(
              top: 20.0,
              left: 20.0,
              child: FloatingActionButton(
                heroTag: mapTypeButtonHeroTag,
                onPressed: _toggleMapType,
                child: Icon((_currentMapType == MapType.normal)
                    ? Icons.satellite
                    : Icons.map),
              ),
            ),
            Positioned(
              top: 100.0,
              left: 20.0,
              child: FloatingActionButton(
                heroTag: locationButtonHeroTag,
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  setState(() {
                    _userLocationMarker = Marker(
                      markerId: MarkerId('userLocation'),
                      position: LatLng(position.latitude, position.longitude),
                      icon: BitmapDescriptor.defaultMarker,
                    );
                  });

                  GoogleMapController controller = await _controller.future;
                  controller.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(position.latitude, position.longitude),
                    ),
                  );
                },
                child: Icon(Icons.location_pin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
