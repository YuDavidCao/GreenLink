import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/home_page/home_hero.dart';
import 'package:solar_web/pages/solar_page/solar_hero.dart';
import 'package:solar_web/widgets/element_group_widget.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';
import 'package:solar_web/widgets/global_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String heroTitleString =
      "The Benefits of Solar Energy: A Guide to Evaluating Your Home";
  static const String heroContentString =
      "Solar energy is clean, renewable, and increasingly affordable. By making the switch to solar power, homeowners can save money on energy bills, reduce their environmental impact, and gain energy independence. Here's how to evaluate your home for efficient solar panel installations:";

  List<Image> costSavingImage = [
    Image.asset(
      "assets/images/solar/CostSaving1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/solar/CostSaving2.jpeg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/solar/CostSaving3.jpg",
      fit: BoxFit.cover,
    ),
  ];

  List<Image> environmentImpactImage = [
    Image.asset(
      "assets/images/solar/EnvironmentImpact1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/solar/EnvironmentImpact2.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/solar/EnvironmentImpact3.jpg",
      fit: BoxFit.cover,
    ),
  ];

  List<String> costSavingTitle = [
    "Lower Your Energy Bills",
    "Protect Against Rising Energy Costs",
    "Invest in Your Home & Future",
  ];

  List<String> environmentImpactTitle = [
    "Reduce Your Carbon Footprint",
    "Limit Water Use",
    "Reduce Pollution",
  ];

  List<String> costSavingContent = [
    "With no monthly electric bill and potential tax credits, homeowners can dramatically reduce their electric bill and potentially even eliminate it altogether.",
    "By producing your own energy, homeowners can reduce their vulnerability to future electricity rate hikes and inflation.",
    "Installing solar panels is an investment in your home and family's future that can boost resale value and provide long-term savings.",
  ];

  List<String> environmentImpactContent = [
    "By switching to clean renewable energy, homeowners can help reduce the amount of carbon emissions that contribute to climate change.",
    "Solar panels use minimal water during operation, which can be particularly beneficial during periods of drought and water scarcity.",
    "By using clean energy, homeowners help reduce air pollution that can trigger a variety of health problems like asthma, lung cancer, and heart attacks.",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool onMobile = width < height;
    if (!onMobile) {
      return Scaffold(
        backgroundColor: sixtyUIColor,
        appBar: globalAppBar(width, onMobile, context),
        body: ListView(
          children: [
            HomeHero(
                onMobile: onMobile,
                height: height,
                width: width,
                heroTitleString: heroTitleString,
                heroContentString: heroContentString),
            const Divider(
              thickness: 5,
              color: thirtyUIColor,
              indent: sectionGapPadding,
              endIndent: sectionGapPadding,
            ),
            ElementGroupWidget(
                title: "Environmental Impact",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                costSavingImage: environmentImpactImage,
                costSavingTitle: environmentImpactTitle,
                costSavingContent: environmentImpactContent),
            const Divider(
              thickness: 5,
              color: thirtyUIColor,
              indent: sectionGapPadding,
              endIndent: sectionGapPadding,
            ),
            ElementGroupWidget(
                title: "Cost Savings",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                costSavingImage: costSavingImage,
                costSavingTitle: costSavingTitle,
                costSavingContent: costSavingContent),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: sixtyUIColor,
        appBar: globalAppBar(width, onMobile, context),
        body: ListView(
          children: [
            HomeHero(
                onMobile: onMobile,
                height: height,
                width: width,
                heroTitleString: heroTitleString,
                heroContentString: heroContentString),
            const Divider(
              thickness: 5,
              color: thirtyUIColor,
              indent: sectionGapPadding,
              endIndent: sectionGapPadding,
            ),
            ElementGroupWidget(
                title: "Environmental Impact",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                costSavingImage: environmentImpactImage,
                costSavingTitle: environmentImpactTitle,
                costSavingContent: environmentImpactContent),
            const Divider(
              thickness: 5,
              color: thirtyUIColor,
              indent: sectionGapPadding,
              endIndent: sectionGapPadding,
            ),
            ElementGroupWidget(
                title: "Cost Savings",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                costSavingImage: costSavingImage,
                costSavingTitle: costSavingTitle,
                costSavingContent: costSavingContent),
          ],
        ),
      );
    }
  }
}
