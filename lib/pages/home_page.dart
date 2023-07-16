import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/cost_saving_widget.dart';
import 'package:solar_web/pages/hero_widget.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String heroTitleString =
      "The Benefits of Solar Energy: A Guide to Evaluating Your Home";
  static const String heroContentString =
      "Solar energy is clean, renewable, and increasingly affordable. By making the switch to solar power, homeowners can save money on energy bills, reduce their environmental impact, and gain energy independence. Here's how to evaluate your home for efficient solar panel installations:";

  List<Image> costSavingImage = [
    Image.asset(
      "assets/images/CostSaving1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/CostSaving2.jpeg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/CostSaving3.jpg",
      fit: BoxFit.cover,
    ),
  ];

  List<String> costSavingTitle = [
    "Lower Your Energy Bills",
    "Protect Against Rising Energy Costs",
    "Invest in Your Home & Future",
  ];

  List<String> costSavingContent = [
    "With no monthly electric bill and potential tax credits, homeowners can dramatically reduce their electric bill and potentially even eliminate it altogether.",
    "By producing your own energy, homeowners can reduce their vulnerability to future electricity rate hikes and inflation.",
    "Installing solar panels is an investment in your home and family's future that can boost resale value and provide long-term savings.",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool onMobile = width < height;
    if (!onMobile) {
      return Scaffold(
        backgroundColor: sixtyUIColor,
        appBar: AppBar(
          toolbarHeight: globalAppBarHeight,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width / 6,
                  ),
                  const Text(
                    "SolarGuide",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        "/HomePage",
                      );
                    },
                    child: const Text("Home",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
                  SizedBox(
                    width: width * 6 / 31,
                  ),
                ],
              )
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HeroWidget(
                      height: height,
                      width: width,
                      heroTitleString: heroTitleString,
                      heroContentString: heroContentString);
                case 1:
                  return const Divider(
                    thickness: 5,
                    color: thirtyUIColor,
                    indent: sectionGapPadding,
                    endIndent: sectionGapPadding,
                  );
                case 2:
                  return CostSavingWidget(
                      width: width,
                      height: height,
                      costSavingImage: costSavingImage,
                      costSavingTitle: costSavingTitle,
                      costSavingContent: costSavingContent);
                case 3:
                  return const Divider(
                    thickness: 5,
                    color: thirtyUIColor,
                    indent: sectionGapPadding,
                    endIndent: sectionGapPadding,
                  );
                default:
                  return null;
              }
            }),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [Text("hello")],
        ),
      );
    }
  }
}
