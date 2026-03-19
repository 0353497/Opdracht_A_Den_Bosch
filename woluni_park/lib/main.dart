import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woluni_park/pages/homepage.dart';
import 'package:woluni_park/providers/favorite_provider.dart';

void main() {
  runApp(const MyApp());
  Get.put<FavoriteProvider>(FavoriteProvider());
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
