import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/hero_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final String heroTitleString =
      "The Benefits of Solar Energy: A Guide to Evaluating Your Home";
  static final String heroContentString =
      "Solar energy is clean, renewable, and increasingly affordable. By making the switch to solar power, homeowners can save money on energy bills, reduce their environmental impact, and gain energy independence. Here's how to evaluate your home for efficient solar panel installations:";

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
