import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mazratii/Models/Location.dart';
import 'package:mazratii/Models/plantmodel.dart'; // Assuming this is where your Plant and Tasks models are defined

import '../Models/plantmodel.dart';
import '../Models/spacesmodel.dart';

class SpaceController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addSpace(Space? space) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('spaces')
          .add({
        'spacetype': space?.type,
        'name': space?.name,
        'latitude': "0",
        'longitude': "0",
      });
      print("Space added");
    } catch (error) {
      print("Failed to add space: $error");
    }
  }

  //////////////////////////////
  static Future<void> addSpacewithlocation(Space? space, location? lo) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('spaces')
          .add({
        'spacetype': space?.type,
        'name': space?.name,
        'latitude': lo?.latitude,
        'longitude': lo?.longitude,
      });
      print("Space added");
    } catch (error) {
      print("Failed to add space: $error");
    }
  }

  ///

  // static Future<void> addPlant(
  //     String spaceId, Plant plant, String spacename) async {
  //   try {
  //     String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(currentUserId)
  //         .collection('spaces')
  //         .doc(spaceId)
  //         .collection('plants')
  //         .add({
  //       'name': plant.plantName,
  //       'time': plant.time,
  //       'spaceId': spaceId,
  //       'spacename': spacename,
  //     });
  //     print("Plant added");
  //   } catch (error) {
  //     print("Failed to add Plant: $error");
  //   }
  // }

//////////////////////

  ///
  List<QueryDocumentSnapshot> spaces = [];

  Future<List<QueryDocumentSnapshot>> getSpaces() async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('spaces')
            .get();
        spaces = querySnapshot.docs;
      }
    } catch (error) {
      print("Error getting spaces: $error");
      // Handle the error as per your requirements
    }
    return spaces;
  }
  ////////////////////////////////
  ///

////////////////
  ///List<QueryDocumentSnapshot> spaces = [];
  Future<void> deleteSpace(int index) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('spaces')
            .get();
        String spaceIdToDelete = querySnapshot.docs[index].id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('spaces')
            .doc(spaceIdToDelete)
            .delete();
      }
    } catch (error) {
      print("Error removing space: $error");
    }
  }
//
  ///
}
//////////////////////////

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
