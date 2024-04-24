import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mazratii/auth/signUp.dart';
import 'package:mazratii/homepage.dart';
import 'package:mazratii/views/FirstPageEver.dart';
import 'package:mazratii/views/addspace.dart';
import 'package:mazratii/views/addspacewithposition.dart';
import 'package:mazratii/views/addtask.dart';
import 'package:mazratii/views/ai.dart';
import 'package:mazratii/views/components/hidden_drawer.dart';
import 'package:mazratii/views/maps.dart';
import 'package:mazratii/views/notificationservice.dart';
import 'package:mazratii/views/plantinfo.dart';
import 'package:mazratii/views/plants.dart';
import 'package:mazratii/views/singlespace.dart';
import 'package:mazratii/views/spacesview.dart';
import 'package:mazratii/views/test.dart';
import 'package:mazratii/views/weather.dart';
import 'auth/login.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await NotificationServices.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("=====================================");
    print(mytoken);
  }

  @override
  void initState() {
    getToken();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '===================================User is currently signed out!');
      } else {
        print('=====================================User is signed in!');
      }
    });
    super.initState();
  }

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? HidenDrawer(
              initPositionSelected: 0,
            )
          : Login(),
      routes: {
        "Signup": (context) => SignUp(),

        "Login": (context) => Login(),
        "Homepage": (context) => HomePage(),
        "maps": (context) => Maps(),
        "Firstpageever": (context) => HidenDrawer(
              initPositionSelected: 0,
            ),
        "addSpace": (context) => addSpace(),
        "addtask": (context) => addtask(),
        "plants": (context) => plantsview(
              SpaceId: '',
              Spacename: '',
            ),
        // "plantInfo": (context) => plantInfo(),
        "spacesview": (context) => HidenDrawer(
              initPositionSelected: 1,
            ),
        "singlespace": (context) => singlespace(),
      },
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
