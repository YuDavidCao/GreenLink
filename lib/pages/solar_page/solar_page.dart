import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/solar_page/solar_hero.dart';
import 'package:solar_web/widgets/element_group_widget.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';
import 'package:solar_web/widgets/global_app_bar.dart';
import 'package:solar_web/widgets/global_drawer.dart';

class SolarPage extends StatefulWidget {
  const SolarPage({super.key});

  @override
  State<SolarPage> createState() => _SolarPageState();
}

class _SolarPageState extends State<SolarPage> {
  static const String heroTitleString =
      "The Benefits of Solar Energy: A Guide to Evaluating Your Home";
  static const String heroContentString =
      "Solar energy is clean, renewable, and increasingly affordable. By making the switch to solar power, homeowners can save money on energy bills, reduce their environmental impact, and gain energy independence. Here's how to evaluate your home for efficient solar panel installations:";

  List<Image> installationImage1 = [
    Image.asset("assets/images/solar/Installation1.png", fit: BoxFit.cover),
    Image.asset("assets/images/solar/Installation2.jpg", fit: BoxFit.cover),
  ];

  List<Image> installationImage2 = [
    Image.asset("assets/images/solar/Installation3.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/solar/Installation4.jpg", fit: BoxFit.cover), 
  ];

  List<String> installationTitle1 = [
    "Roof Analysis",
    "Sun Exposure",
  ];

  List<String> installationTitle2 = [
    "Questions to Ask Solar Panel Installers",
    'Financing Options',
  ];

  List<String> installationContent1 = [
    "A proper roof analysis is crucial to determining the viability of a solar panel installation for your home, including its condition and age.",
    "The position and exposure of a roof to the sun can make a big difference in the effectiveness of a solar panel system.",
  ];

  List<String> installationContent2 = [
    "Choosing a qualified solar panel installer requires careful research into their credentials, experience, and available financing options.",
    "Solar panel financing options can be complex, but they can greatly reduce the cost of a panel system and make them an affordable option for many homeowners.",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool onMobile = width < height;
    if (!onMobile) {
      return Scaffold(
        backgroundColor: sixtyUIColor,
        appBar: globalAppBar(width, onMobile, context, height),
        body: ListView(
          children: [
            SolarHero(
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
                title: "Evaluating Your Home for Solar Panel Installation",
                onMobile: onMobile,
                ratio: 3.5,
                width: width,
                height: height,
                groupImage: installationImage1,
                groupTitle: installationTitle1,
                groupContent: installationContent1),
            ElementGroupWidget(
                title: "",
                onMobile: onMobile,
                ratio: 3.5,
                width: width,
                height: height,
                groupImage: installationImage2,
                groupTitle: installationTitle2,
                groupContent: installationContent2),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: sixtyUIColor,
        drawer: (!kIsWeb) ?  const GlobalDrawer(currentPage: "Solar") : null,
        appBar: globalAppBar(width, onMobile, context, height),
        body: ListView(
          children: [
            SolarHero(
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
            if (!onMobile)
              ElementGroupWidget(
                  title: "Evaluating Your Home for Solar Panel Installation",
                  onMobile: onMobile,
                  ratio: 3.5,
                  width: width,
                  height: height,
                  groupImage: installationImage1,
                  groupTitle: installationTitle1,
                  groupContent: installationContent1),
            if (!onMobile)
              ElementGroupWidget(
                  onMobile: onMobile,
                  title: "",
                  ratio: 3.5,
                  width: width,
                  height: height,
                  groupImage: installationImage2,
                  groupTitle: installationTitle2,
                  groupContent: installationContent2),
            if (onMobile)
              ElementGroupWidget(
                  onMobile: onMobile,
                  title: "",
                  ratio: 3.5,
                  width: width,
                  height: height,
                  groupImage: installationImage1 + installationImage2,
                  groupTitle: installationTitle1 + installationTitle2,
                  groupContent:
                      installationContent1 + installationContent2),
          ],
        ),
      );
    }
  }
}
