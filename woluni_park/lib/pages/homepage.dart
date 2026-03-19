import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woluni_park/pages/attractions_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Tween<double> opacityAnimation = Tween(begin: 0, end: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          TweenAnimationBuilder(
            tween: opacityAnimation,
            duration: 1.seconds,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.asset("assets/images/hero.png"),
                    ),
                    SizedBox(height: Get.height * .17),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 64,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Beleef een dag vol spanning en plezier in Woluni Park. Ontdek spectaculaire attracties, korte wachttijden en onvergetelijke avonturen voor jong en oud.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 60,
                            width: double.maxFinite,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Color(0xffFF5617),
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              onPressed: () => Get.to(() => AttractionsPage()),
                              child: Text(
                                "Bekijk alle attracties",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Center(child: Image.asset("assets/images/woluni_park.png")),
        ],
      ),
    );
  }
}
