import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/home_page/home_hero.dart';
import 'package:solar_web/widgets/element_group_widget.dart';
import 'package:solar_web/widgets/global_app_bar.dart';
import 'package:solar_web/widgets/global_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String heroTitleString = "The Power of Renewable Energy";
  static const String heroContentString =
      "Renewable energy is the solution to the environmental and economic challenges of this generation. It is reliable, sustainable, and produces zero emissions. Join us in the journey towards a brighter and cleaner future with renewable energy.";

  List<Image> costSavingImage = [
    Image.asset(
      "assets/images/home/CostSaving1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/home/CostSaving2.jpeg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/home/CostSaving3.jpg",
      fit: BoxFit.cover,
    ),
  ];

  List<Image> environmentImpactImage = [
    Image.asset(
      "assets/images/home/EnvironmentImpact1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/home/EnvironmentImpact2.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/home/EnvironmentImpact3.jpg",
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
    "Improved air quality",
    "Reduce Pollution",
  ];

  List<String> costSavingContent = [
    "With no monthly electric bill and potential tax credits, homeowners can dramatically reduce their electric bill and potentially even eliminate it altogether.",
    "By producing your own energy, homeowners can reduce their vulnerability to future electricity rate hikes and inflation.",
    "Installing solar panels is an investment in your home and family's future that can boost resale value and provide long-term savings.",
  ];

  List<String> environmentImpactContent = [
    "By switching to clean renewable energy, homeowners can help reduce the amount of carbon emissions that contribute to climate change.",
    "Unlike fossil fuels, renewable energy technologies like wind, solar, and hydroelectric power do not release harmful pollutants and particulates that contribute to air pollution and smog.",
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
        appBar: globalAppBar(width, onMobile, context, height),
        body: ListView(
          children: [
            HomeHero(
                onMobile: onMobile,
                height: height,
                width: width,
                heroTitleString: heroTitleString,
                heroContentString: heroContentString),
            ElementGroupWidget(
                title: "Environmental Impact",
                onMobile: onMobile,
                ratio: 5,
                width: width,
                height: height,
                groupImage: environmentImpactImage,
                groupTitle: environmentImpactTitle,
                groupContent: environmentImpactContent),
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
                groupImage: costSavingImage,
                groupTitle: costSavingTitle,
                groupContent: costSavingContent),
          ],
        ),
      );
    } else {
      return Scaffold(
        drawer: (!kIsWeb) ?  const GlobalDrawer(currentPage: "Home") : null,
        backgroundColor: sixtyUIColor,
        appBar: globalAppBar(width, onMobile, context, height),
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
                groupImage: environmentImpactImage,
                groupTitle: environmentImpactTitle,
                groupContent: environmentImpactContent),
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
                groupImage: costSavingImage,
                groupTitle: costSavingTitle,
                groupContent: costSavingContent),
          ],
        ),
      );
    }
  }
}
