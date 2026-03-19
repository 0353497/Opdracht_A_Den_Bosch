import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:woluni_park/components/floating_nav_bar.dart';
import 'package:woluni_park/pages/attractions_details_page.dart';
import 'package:woluni_park/services/json_reader.dart';

class AttractionsPage extends StatefulWidget {
  const AttractionsPage({super.key});

  @override
  State<AttractionsPage> createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  int selectedCategory = 0;
  late Future<List> allAttractions;
  List allAttractionsValue = [];
  List filteredAttractions = [];
  @override
  void initState() {
    super.initState();
    allAttractions = JsonReader.readJson("assets/attractions.json");
    init();
  }

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
                      PillCategoryContainer(
                        onTap: () => applyCategory(0),
                        text: 'Alles',
                        isSelectedCategory: selectedCategory == 0,
                      ),
                      PillCategoryContainer(
                        onTap: () => applyCategory(1),
                        text: 'AchtBanen',
                        isSelectedCategory: selectedCategory == 1,
                      ),
                      PillCategoryContainer(
                        onTap: () => applyCategory(2),
                        text: 'Waterattracties',
                        isSelectedCategory: selectedCategory == 2,
                      ),
                      PillCategoryContainer(
                        onTap: () => applyCategory(3),
                        text: 'Familieattracties',
                        isSelectedCategory: selectedCategory == 3,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: allAttractions,
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!asyncSnapshot.hasData) {
                      return Center(child: Text("no data"));
                    }
                    return ListView.builder(
                      itemCount: filteredAttractions.length,
                      itemBuilder: (context, index) {
                        final attraction = filteredAttractions[index];
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

  void init() async {
    filteredAttractions = await allAttractions;
    allAttractionsValue = await JsonReader.readJson("assets/attractions.json");
  }

  Future<void> applyCategory(int categoryIndex) async {
    selectedCategory = categoryIndex;
    filteredAttractions = allAttractionsValue;
    if (categoryIndex == 1) {
      filteredAttractions = allAttractionsValue
          .where((value) => value["category"] == "rollercoaster")
          .toList();
    }
    if (categoryIndex == 2) {
      filteredAttractions = allAttractionsValue
          .where((value) => value["category"] == "water")
          .toList();
    }
    if (categoryIndex == 3) {
      filteredAttractions = allAttractionsValue
          .where((value) => value["category"] == "family")
          .toList();
    }
    setState(() {});
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
    required this.isSelectedCategory,
  });
  final bool isSelectedCategory;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelectedCategory ? Colors.white : const Color(0x33C3C3C3),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelectedCategory ? Color(0xffff5617) : Color(0xff303030),
          ),
        ),
      ),
    );
  }
}
