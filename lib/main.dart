import 'package:flutter/material.dart';
import 'package:notification_flutter/notificationApi.dart';
import 'package:get_storage/get_storage.dart';
import 'MyHomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  NotificationApi.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


