import 'package:flutter/material.dart';
import 'package:mazratii/Models/plantmodel.dart';
import 'package:mazratii/controller/plantscontroller.dart';
import 'package:mazratii/views/NotificationService.dart';
import 'package:mazratii/views/components/buttomnavbar.dart';
import 'package:mazratii/views/components/details.dart';
import 'package:mazratii/controller/spacescontroller.dart';
import 'package:mazratii/views/spacesview.dart';
import '../Models/sch.dart';
import '../Models/taskmodel.dart';
import 'components/addbutton.dart';
import 'components/containertitle.dart';
import 'components/plantcontainer.dart';

class OurPlantDetails extends StatefulWidget {
  final Plant plant;

  const OurPlantDetails({
    super.key,
    required this.plant,
  });

  @override
  State<OurPlantDetails> createState() => _OurPlantDetailsState();
}

class _OurPlantDetailsState extends State<OurPlantDetails> {
  DateTime now = DateTime.now();
  bool _isLoading = false;
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: const Color.fromARGB(0, 255, 255, 255),
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: Image.asset(
                            "images/${widget.plant.image}",
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 100),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
                      child: Text(
                        "${widget.plant.plantName}",
                        textAlign: TextAlign.right, // Align text to the right
                        textDirection: TextDirection
                            .rtl, // Set text direction to right-to-left
                        style: TextStyle(fontSize: 35, color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              containertitle(
                titlee: 'أهم المعلومات',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  details(
                    plantAge: 'الحاجيات المائية',
                    plantImage: 'water.png',
                    plantName: widget.plant.water,
                  ),
                  details(
                    plantAge: 'مدة النمو',
                    plantImage: 'Time.png',
                    plantName: widget.plant.Duration_of_growth,
                  ),
                  details(
                    plantAge: 'الفصل المفضل',
                    plantImage: 'weather.png',
                    plantName: widget.plant.season,
                  ),
                ],
              ),
              containertitle(
                titlee: 'المعلومات العامة',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.plant.description,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection
                            .rtl, // Set text direction to right-to-left
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: buttomnavbar(),
    );
  }
}
