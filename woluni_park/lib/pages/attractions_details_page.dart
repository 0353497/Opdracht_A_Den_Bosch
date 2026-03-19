import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woluni_park/providers/favorite_provider.dart';
import 'package:woluni_park/services/time_service.dart';

class AttractionsDetailsPage extends StatefulWidget {
  const AttractionsDetailsPage({super.key, this.attraction});
  final dynamic attraction;
  @override
  State<AttractionsDetailsPage> createState() => _AttractionsDetailsPageState();
}

class _AttractionsDetailsPageState extends State<AttractionsDetailsPage> {
  final provider = Get.find<FavoriteProvider>();
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = provider.favoriteAttractionIds.contains(
      widget.attraction["id"],
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/${widget.attraction["image"]}",
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.grey.withAlpha(120),
                      ),
                    ),
                    onPressed: () {
                      if (provider.favoriteAttractionIds.contains(
                        widget.attraction["id"],
                      )) {
                        provider.favoriteAttractionIds.remove(
                          widget.attraction["id"],
                        );
                      } else {
                        provider.favoriteAttractionIds.add(
                          widget.attraction["id"],
                        );
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(widget.attraction["category"]),
                  Column(
                    spacing: 12,
                    children: [
                      Text(
                        widget.attraction["name"],
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xffff5617),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Bakbak_One",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: TimeService.getColorBasedOnDelayAlpha(
                            int.parse(widget.attraction["wait_time"]),
                          ),
                          border: BoxBorder.all(
                            color: TimeService.getColorBasedOnDelay(
                              int.parse(widget.attraction["wait_time"]),
                            ),
                          ),
                        ),
                        child: Text(
                          "${widget.attraction["wait_time"]} min wachttijd",
                          style: TextStyle(
                            color: TimeService.getColorBasedOnDelay(
                              int.parse(widget.attraction["wait_time"]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.attraction["description"]}",
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DetailContainerWidget(
                        label: "Minimale lengte",
                        value: "${widget.attraction["minimal_length"]} cm",
                      ),
                      DetailContainerWidget(
                        label: "Snelheid",
                        value: "${widget.attraction["speed"]} km/h",
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 60,
                      width: Get.width * .35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xbbC3C3C3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 12,
                          children: [Icon(Icons.close), Text("Sluiten")],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailContainerWidget extends StatelessWidget {
  const DetailContainerWidget({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Color(0xbbC3C3C3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Text(label),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: Color(0xffff5617),
                fontWeight: FontWeight.bold,
                fontFamily: "Bakbak_One",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
