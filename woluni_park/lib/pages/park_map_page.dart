import 'package:flutter/material.dart';
import 'package:woluni_park/components/floating_nav_bar.dart';
import 'package:woluni_park/pages/attractions_page.dart';

class ParkMapPage extends StatefulWidget {
  const ParkMapPage({super.key});

  @override
  State<ParkMapPage> createState() => _ParkMapPageState();
}

class _ParkMapPageState extends State<ParkMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingNavBar(active: 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Attracties",
          style: TextStyle(
            fontSize: 40,
            color: Color(0xffff5617),
            fontWeight: FontWeight.bold,
            fontFamily: "Bakbak_One",
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/lines.png")),
        ],
      ),
    );
  }
}
