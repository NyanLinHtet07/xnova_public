import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'package:xnova/utilities/update_checker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UpdateService.checkForUpdate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xnova',
      theme: ThemeData(
        primaryColor: Colors.cyan[800],
        primarySwatch: Colors.cyan,
      ),
      home: MainScreen(),
    );
  }
}
