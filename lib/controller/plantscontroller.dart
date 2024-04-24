import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/plantmodel.dart';

class PlantController {
  List<QueryDocumentSnapshot> spaces = [];
  static Future<void> addPlant(
      String spaceId, Plant plant, String spacename) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      DocumentReference spaceRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('spaces')
          .doc(spaceId);
      Timestamp timestamp = Timestamp.fromDate(plant.time);

      DocumentReference plantRef = await spaceRef.collection('plants').add({
        'name': plant.plantName,
        'time': timestamp,
        'season': plant.season,
        'water': plant.water,
        'description': plant.description,
        'spaceId': spaceId,
        'image': plant.image,
        'ageofplant': plant.age,
      });

      CollectionReference tasksRef = spaceRef.collection('tasks');
      for (var task in plant.tasks) {
        await tasksRef.add({
          'plantId': plantRef.id,
          'name': task.name,
          'description': task.description,
          'day': task.day,
          'plantName': plant.plantName,
          'completed': false, // Adding a boolean variable
        });
      }

      print("Plant added");
    } catch (error) {
      print("Failed to add Plant: $error");
    }
  }

  Future<List<QueryDocumentSnapshot>> getPlants(spaceId) async {
    try {
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('spaces')
            .doc(spaceId)
            .collection('plants')
            .get();
        spaces = querySnapshot.docs;
      }
    } catch (error) {
      print("Error getting spaces: $error");
      // Handle the error as per your requirements
    }
    return spaces;
  }
}
