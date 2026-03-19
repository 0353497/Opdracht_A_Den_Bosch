import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:woluni_park/components/floating_nav_bar.dart';
import 'package:woluni_park/pages/attractions_details_page.dart';
import 'package:woluni_park/pages/park_map_page.dart';
import 'package:woluni_park/services/json_reader.dart';

class AttractionsPage extends StatefulWidget {
  const AttractionsPage({super.key});

  @override
  State<AttractionsPage> createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingNavBar(active: 0),
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
        actions: [
          InkWell(
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset("assets/images/up_down.png"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 12,
                    children: [
                      PillCategoryContainer(onTap: () {}, text: 'Alles'),
                      PillCategoryContainer(onTap: () {}, text: 'AchtBanen'),
                      PillCategoryContainer(
                        onTap: () {},
                        text: 'Waterattracties',
                      ),
                      PillCategoryContainer(
                        onTap: () {},
                        text: 'Familieattracties',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: JsonReader.readJson("assets/attractions.json"),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!asyncSnapshot.hasData) {
                      return Center(child: Text("no data"));
                    }
                    return ListView.builder(
                      itemCount: asyncSnapshot.data!.length,
                      itemBuilder: (context, index) {
                        final attraction = asyncSnapshot.data![index];
                        return AttractionDetailListTile(
                          attraction: attraction,
                          onTap: () => Get.to(
                            () =>
                                AttractionsDetailsPage(attraction: attraction),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttractionDetailListTile extends StatelessWidget {
  const AttractionDetailListTile({
    super.key,
    required this.attraction,
    required this.onTap,
  });

  final VoidCallback onTap;
  final dynamic attraction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            Badge(
              label: Icon(Icons.star),
              isLabelVisible: false,
              child: Transform.scale(
                scale: 1.3,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      width: 100,
                      height: 100,
                      "assets/images/${attraction["image"]}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.redAccent,
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(attraction["name"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${attraction["category"]} • ${attraction["speed"]} km/u"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green.withAlpha(100),
                border: BoxBorder.all(color: Colors.green),
              ),
              child: Text(
                "${attraction["wait_time"]} min",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PillCategoryContainer extends StatelessWidget {
  const PillCategoryContainer({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor = const Color(0x33C3C3C3),
    this.textColor = const Color(0xff303030),
  });
  final VoidCallback onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
