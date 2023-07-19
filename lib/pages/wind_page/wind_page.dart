import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/solar_page/solar_hero.dart';
import 'package:solar_web/pages/wind_page/wind_hero.dart';
import 'package:solar_web/widgets/element_group_widget.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';
import 'package:solar_web/widgets/global_app_bar.dart';
import 'package:solar_web/widgets/global_drawer.dart';

class WindPage extends StatefulWidget {
  const WindPage({super.key});

  @override
  State<WindPage> createState() => _WindPageState();
}

class _WindPageState extends State<WindPage> {
  static const String heroTitleString = "Harnessing the Power of Wind Energy";
  static const String heroContentString =
      "Discover how wind energy can provide a sustainable and clean energy source for your home. Reduce your carbon footprint, lower your energy bills, and join the global effort to combat climate change with personal wind turbines.";

  List<Image> siteSelectionImage = [
    Image.asset(
      "assets/images/wind/SiteSelection1.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/wind/SiteSelection2.jpeg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/wind/SiteSelection3.png",
      fit: BoxFit.cover,
    ),
  ];

  List<Image> maintainanceImage = [
    Image.asset(
      "assets/images/wind/Maintainance1.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/wind/Maintainance2.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/wind/Maintainance3.jpg",
      fit: BoxFit.cover,
    ),
  ];

  List<String> siteSelectionTitle = [
    "Wind Speed",
    "Available Space",
    "Environmental Impact",
  ];

  List<String> maintainanceTitle = [
    "Cleanliness",
    "Inspection and Repair",
    "Professional Servicing",
  ];

  List<String> siteSelectionContent = [
    "The most important factor when selecting a site is wind speed. A good wind location typically has wind speeds of at least 6 meter per second.",
    "Personal wind turbines require enough space for the tower and rotor blades. Typically, you need an open area of half an acre or more for a tower height of 80 to 120 feet..",
    "The installation of a wind turbine can affect the environment, such as noise pollution. It's essential to consider the environmental factors before the installation process.",
  ];

  List<String> maintainanceContent = [
    "Regularly clean the turbine and equipment since it operates in an outdoor environment.",
    "Conduct regular inspections to identify any issues or faults that require repair.",
    "Engage professional technicians to perform annual maintenance services to ensure optimal performance and longevity of the turbine.",
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
            WindHero(
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
                title: "Site Selection for Personal Wind Turbine",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                groupImage: siteSelectionImage,
                groupTitle: siteSelectionTitle,
                groupContent: siteSelectionContent),
            const Divider(
              thickness: 5,
              color: thirtyUIColor,
              indent: sectionGapPadding,
              endIndent: sectionGapPadding,
            ),
            ElementGroupWidget(
                title: "Maintenance of Personal Wind Turbine",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                groupImage: maintainanceImage,
                groupTitle: maintainanceTitle,
                groupContent: maintainanceContent),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: sixtyUIColor,
        drawer: (!kIsWeb) ? const GlobalDrawer(currentPage: "Wind") : null,
        appBar: globalAppBar(width, onMobile, context, height),
        body: ListView(
          children: [
            WindHero(
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
                title: "Site Selection for Personal Wind Turbine",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                groupImage: siteSelectionImage,
                groupTitle: siteSelectionTitle,
                groupContent: siteSelectionContent),
            const Divider(
              thickness: 5,
              color: thirtyUIColor,
              indent: sectionGapPadding,
              endIndent: sectionGapPadding,
            ),
            ElementGroupWidget(
                title: "Maintenance of Personal Wind Turbine",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                groupImage: maintainanceImage,
                groupTitle: maintainanceTitle,
                groupContent: maintainanceContent),
          ],
        ),
      );
    }
  }
}
