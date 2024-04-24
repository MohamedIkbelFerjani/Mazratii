import 'package:flutter/material.dart';

class WriteContainer extends StatefulWidget {
  final String hintText;
  const WriteContainer({Key? key, required this.hintText}) : super(key: key);

  @override
  WriteContainerState createState() => WriteContainerState();
}

class WriteContainerState extends State<WriteContainer> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 242, 242),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _textEditingController,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  String get writtenText => _textEditingController.text;
}
