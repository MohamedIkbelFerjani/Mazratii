import 'dart:io'; // Add this import for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazratii/views/DiseaseView.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../database/Diseases/Disease.dart';

class AI extends StatefulWidget {
  String model;
  String label;
  AI({Key? key, required this.model, required this.label}) : super(key: key);

  @override
  State<AI> createState() => _AIState();
}

class _AIState extends State<AI> {
  final String mapTypeButtonHeroTag = 'mapTypeButton';
  final String locationButtonHeroTag = 'locationButton';
  List? _outputs;
  XFile? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? CircularProgressIndicator()
                : _image == null
                    ? Text('لم تختار صورة بعد')
                    : Image.file(File(_image!.path)),
            SizedBox(height: 20), // Add some space between image and text
            _outputs != null
                ? Text(
                    'Classification: ${_outputs![0]['label']}',
                    style: TextStyle(fontSize: 16),
                  )
                : Container(), // Show an empty container if outputs are null
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: takePicture,
              heroTag: mapTypeButtonHeroTag,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          ),
          FloatingActionButton(
            onPressed: pickImage,
            heroTag: locationButtonHeroTag,
            tooltip: 'Pick Image',
            child: Icon(Icons.image),
          ),
        ],
      ),
    );
  }

  Future<void> takePicture() async {
    XFile? imageFile;

    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile == null) return;

    setState(() {
      _loading = true;
      _image = imageFile;
    });

    classifyImage(imageFile);
  }

  Future<void> pickImage() async {
    XFile? imageFile;

    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    setState(() {
      _loading = true;
      _image = imageFile;
    });
    classifyImage(imageFile);
  }

  classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });

    if (_outputs != null && _outputs!.isNotEmpty) {
      print("////////////////////////////////////////${_outputs![0]['label']}");
      Disease? disease = diseases[_outputs![0]['label']];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiseaseView(
            disease: disease,
            image: image,
          ),
        ),
      );
    }
    print("////////////////////////////////////////${_outputs![0]['label']}");    
  }

  loadModel() async {
    await Tflite.loadModel(
      model: widget.model,
      labels: widget.label,
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
