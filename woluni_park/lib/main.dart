import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:woluni_park/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "Lato"),
      title: 'Woluni Park',
      home: const Homepage(),
    );
  }
}
