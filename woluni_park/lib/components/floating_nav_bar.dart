import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:woluni_park/pages/attractions_page.dart';
import 'package:woluni_park/pages/park_map_page.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key, required this.active});
  final int active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: Get.width * .35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: AlignmentGeometry.bottomCenter,
          end: AlignmentGeometry.topCenter,
          colors: [Colors.grey, Colors.white],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 12,
          children: [
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  active == 0 ? Color(0xffFF5617) : Colors.white,
                ),
              ),
              onPressed: () => Get.to(() => AttractionsPage()),
              icon: Image.asset("assets/images/menu_square.png"),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  active == 1 ? Color(0xffFF5617) : Colors.white,
                ),
              ),
              onPressed: () => Get.to(() => ParkMapPage()),
              icon: Image.asset("assets/images/marker_outline.png"),
            ),
          ],
        ),
      ),
    );
  }
}
