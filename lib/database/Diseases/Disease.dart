import 'package:mazratii/database/Diseases/Alternaria_Solanii.dart';
import 'package:mazratii/database/Diseases/Healthy.dart';
import 'package:mazratii/database/Diseases/Phytophthora_infestans.dart';
import 'package:mazratii/database/Diseases/Virus.dart';
import 'package:mazratii/database/Diseases/Strawberry___healthy.dart';
import 'package:mazratii/database/Diseases/Strawberry___Leaf_scorch.dart';
import 'package:mazratii/database/Diseases/insect.dart';

import 'Pepper,_bell___Bacterial_spot.dart';
import 'Scroch.dart';

class Disease {
  late String name;
  late String Cause; // المسبب المرضى
  late String conditions; // الظروف المالئمة لحدوث المرض وتطوره
  late String symptoms; // أعراض
  late String preventionAndTreatment; // طرق الوقاية والعلاج

  Disease(
      {required this.name,
      required this.Cause,
      required this.conditions,
      required this.symptoms,
      required this.preventionAndTreatment});
}

final Map<String, Disease> diseases = {
  "Phytopthora Infestans": Phytophthora_infestans,
  "Alternaria Solani": Alternaria_Solani,
  "leafScorch": leafScorch,
  "VirusY": VirusY,
  "Healthy": Healthy,
  "Insect": Insect,
  "Strawberry___healthy": Strawberry___healthy,
  "Strawberry___Leaf_scorch": Strawberry_Leaf_Scorch,
  "Strawberry___Leaf_scorch": Strawberry_Leaf_Scorch,
  "Pepper,_bell___Bacterial_spot": Pepper_bell_Bacterial_Spot,
  "Pepper,_bell___healthy": Healthy,
};
