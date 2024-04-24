import 'package:firebase_storage/firebase_storage.dart';
import 'package:mazratii/Models/taskmodel.dart';

class Plant {
  final int id;
  int age;
  final String plantName;
  final DateTime time;
  final String season;
  final String water;
  final String image;
  final String description;
  final int spaceId;
  String Duration_of_growth;
  List<Tasks> tasks;

  Plant({
    required this.id,
    required this.age,
    required this.Duration_of_growth,
    required this.plantName,
    required this.time,
    required this.image,
    required this.season,
    required this.water,
    required this.description,
    required this.spaceId,
    required this.tasks,
  });
}
