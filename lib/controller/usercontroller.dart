import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserController {
  Future<Map<String, dynamic>?> getUserDetails(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final name = user.displayName;
      final email = user.email;
      final photoUrl = user.photoURL;
      final emailVerified = user.emailVerified;
      final uid = user.uid;

      // Return user details as a map
      return {
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'emailVerified': emailVerified,
        'uid': uid,
      };
    } else {
      // If user is not signed in, return null
      return null;
    }
  }

  Future<String?> getUserName(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name of the user
      final name = user.displayName;
      return name;
    } else {
      // Return null if user is not signed in
      return null;
    }
  }
}
