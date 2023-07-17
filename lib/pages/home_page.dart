import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/hero_widget.dart';
import 'package:solar_web/pages/row_of_element_widget.dart';
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

  List<Image> environmentImpactImage = [
    Image.asset(
      "assets/images/EnvironmentImpact1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/EnvironmentImpact2.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/EnvironmentImpact3.jpg",
      fit: BoxFit.cover,
    ),
  ];

  List<Image> installationImage1 = [
    Image.asset("assets/images/Installation1.png", fit: BoxFit.cover),
    Image.asset("assets/images/Installation2.jpg", fit: BoxFit.cover),
  ];

  List<Image> installationImage2 = [
    Image.asset("assets/images/Installation3.jpg", fit: BoxFit.cover),
    Image.asset("assets/images/Installation4.jpg", fit: BoxFit.cover),
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

  List<String> installationTitle1 = [
    "Roof Analysis",
    "Sun Exposure",
  ];

  List<String> installationTitle2 = [
    "Questions to Ask Solar Panel Installers",
    'Financing Options',
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
                  return RowOfElementWidget(
                      title: "Environmental Impact",
                      ratio: 5,
                      width: width,
                      height: height,
                      costSavingImage: environmentImpactImage,
                      costSavingTitle: environmentImpactTitle,
                      costSavingContent: environmentImpactContent);
                case 3:
                  return const Divider(
                    thickness: 5,
                    color: thirtyUIColor,
                    indent: sectionGapPadding,
                    endIndent: sectionGapPadding,
                  );
                case 4:
                  return RowOfElementWidget(
                      title: "Cost Savings",
                      ratio: 5,
                      width: width,
                      height: height,
                      costSavingImage: costSavingImage,
                      costSavingTitle: costSavingTitle,
                      costSavingContent: costSavingContent);
                case 5:
                  return const Divider(
                    thickness: 5,
                    color: thirtyUIColor,
                    indent: sectionGapPadding,
                    endIndent: sectionGapPadding,
                  );
                case 6:
                  return RowOfElementWidget(
                      title: "Evaluating Your Home for Solar Panel Installation",
                      ratio: 3.5,
                      width: width,
                      height: height,
                      costSavingImage: installationImage1,
                      costSavingTitle: installationTitle1,
                      costSavingContent: installationContent1);
                case 7:
                  return RowOfElementWidget(
                      title: "",
                      ratio: 3.5,
                      width: width,
                      height: height,
                      costSavingImage: installationImage2,
                      costSavingTitle: installationTitle2,
                      costSavingContent: installationContent2);
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
