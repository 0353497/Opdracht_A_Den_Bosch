import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:woluni_park/components/floating_nav_bar.dart';
import 'package:woluni_park/pages/attractions_details_page.dart';
import 'package:woluni_park/services/json_reader.dart';

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
      body: FutureBuilder(
        future: JsonReader.readJson("assets/attractions.json"),
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) return SizedBox();
          return Stack(
            children: [
              Positioned.fill(child: Image.asset("assets/images/lines.png")),
              for (int i = 0; i < asyncSnapshot.data!.length; i++)
                Positioned(
                  left: double.parse(
                    (asyncSnapshot.data![i]["position"]["mapX"] * 9).toString(),
                  ),
                  top: double.parse(
                    (asyncSnapshot.data![i]["position"]["mapY"] * 18)
                        .toString(),
                  ),
                  child: IconButton(
                    onPressed: () => Get.to(
                      () => AttractionsDetailsPage(
                        attraction: asyncSnapshot.data![i],
                      ),
                    ),
                    icon: Icon(
                      Icons.location_on,
                      color: Color(0xffff5617),
                      size: 48,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
