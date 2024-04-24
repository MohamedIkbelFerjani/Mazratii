import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazratii/database/Diseases/Disease.dart';

class DiseaseView extends StatefulWidget {
  final Disease? disease;
  final XFile image;
  const DiseaseView({super.key, required this.disease, required this.image});

  @override
  State<DiseaseView> createState() => _DiseaseViewState();
}

class _DiseaseViewState extends State<DiseaseView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.disease!.name),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.file(File(widget.image.path)),
              SizedBox(height: 10),
              Text('اسم المرض: ${widget.disease!.name}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('السبب: ${widget.disease!.Cause}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('الظروف: ${widget.disease!.conditions}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('الوقاية والعلاج:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(widget.disease!.preventionAndTreatment,
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('الأعراض:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(widget.disease!.symptoms, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
