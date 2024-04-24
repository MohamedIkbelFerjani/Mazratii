import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mazratii/Models/usermodel.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // Additional operations if necessary
        // ignore: unnecessary_cast
        model.User user = model.User(
          uid: cred.user!.uid,
          username: username,
          email: email,
          spaces: [],
        );
        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        await _firestore.collection('users').add({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'spaces': [],
        });
        // If the registration is successful, you can set 'res' to a success message
        res = "Registration successful";
      } else {
        res = "Email, password, and username cannot be empty";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  // Login with google

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential cred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get user details
      String? username = cred.user?.displayName;
      String? email = cred.user?.email;

      // Save user data to Firestore
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'spaces': [],
      });

      await _firestore.collection('users').add({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'spaces': [],
      });

      return cred;
    } catch (e) {
      // Handle error appropriately, such as displaying an error message to the user
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while signing in with Google.'),
        ),
      );
      throw e; // Re-throwing the error for the caller to handle if necessary
    }
  }
}
