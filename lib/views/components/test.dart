// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:mazratii/components/notif.dart';
// import 'package:timezone/data/latest.dart' as tz; 

// class Love extends StatefulWidget {
  
//   const Love({super.key});

//   @override
//   State<Love> createState() => _LoveState();
// }

// class _LoveState extends State<Love> {
//   getToken() async {
//     String? mytoken = await FirebaseMessaging.instance.getToken();
//     print("=====================================");
//     print(mytoken);
//   }

//   @override
//   void initState() {
//     getToken();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(child: Text('Show Notification'),
//         onPressed: (){
//           NotificationService().showNotification(title: 'Sample Title',body: 'Its Working' );
//         }),
//       ),
//     );
//   }
// }
// // void requestPermission() async {
// // FirebaseMessaging messagfing = FirebaseMessaging. instance;

// // NotificationSettings settings = await messaging. requestPermission(
// // alert: true,
// // announcement: false,
// // badge: true,
// // carPlay: false,
// // criticalAlert: false,
// // provisional: false,
// // sound: true,

// // );

// // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
// // print('User granted permission');
// // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
// // print('User granted provisional permission');
// // } else {
// // print('User declined or has not accepted permission');

// //   }}
// // class DatePickerTxt extends StatefulWidget {
// // const DatePickerTxt ({
// // Key? key,
// // }) : super(key: key);

// // @override
// // State<DatePickerTxt> createState() =>_DatePickerTxtState();

// // }

// // class _DatePickerTxtState extends State<DatePickerTxt> {
// // @override
// // Widget build(BuildContext context) {
// // return TextButton(
// // onPressed: () {
// //   DatePicker.showDateTimePicker()
// // },
// // child: const Text(
// // 'Select Date Time',
// // style: TextStyle(
// //   color: Colors.blue,
// // ), // Text
// // ));
// //  } // TextButton



// // }