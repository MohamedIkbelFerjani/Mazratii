import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class taskcontroller {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addTask(
      String? spaceId,
      DateTime day,
      // TimeOfDay? time, // Add TimeOfDay parameter
      String spacename,
      String taskName) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      DocumentReference spaceRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('spaces')
          .doc(spaceId);
      // Convert TimeOfDay to DateTime
      // DateTime dateTime = DateTime(
      //   day!.year,
      //   day.month,
      //   day.day,
      //   time!.hour,
      //   time.minute,
      // );
      DocumentReference taskRef = await spaceRef.collection('tasks').add({
        'name': taskName,
        'day': 0,
        'date': Timestamp.fromDate(day),
        // 'time': '${time.hour}:${time.minute}', // Store time as TimeOfDay
        'description': '',
        'plantId': '',
        'plantName': '',
        'completed': false, 
      });

      print("Task added");
    } catch (error) {
      print("Failed to add Task: $error");
    }
  }
}
