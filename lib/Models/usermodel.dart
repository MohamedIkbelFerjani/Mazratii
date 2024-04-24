import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mazratii/Models/spacesmodel.dart'; // Import the Space class from the correct file

class User {
  final String uid;
  final String username;
  final String email;
  final List<Space> spaces; // Add spaces list property

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.spaces,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username, // Corrected 'name' to 'username'
      'email': email,
      'spaces': spaces.map((space) => space.toJson()).toList(),
    };
  }
}
