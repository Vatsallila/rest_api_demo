import 'package:flutter/material.dart';
import 'package:rest_api_demo/demo.dart';
import 'package:rest_api_demo/demo_homescreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home:  ApiCall1(),
    );
  }
}
