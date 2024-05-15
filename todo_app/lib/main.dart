import 'package:flutter/material.dart';
import 'package:todo_app/utilities/send_notification.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // init the hive
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  // init the local notification
  await SendNotification().initNotification(); // class'ın içindeki fonksiyonu burada çalıştırmış olduk
  tz.initializeTimeZones();

  // open a box
  var box = await Hive.openBox('mybox');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.pink[200], foregroundColor: Colors.white),
      ),
    );
  }
}