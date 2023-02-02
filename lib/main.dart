import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:testnot/home_screen.dart';
import 'package:testnot/notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("----------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  print(message.data.toString());
  print(message.notification!.title);
  print("----------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  NotificationService.initialize();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
