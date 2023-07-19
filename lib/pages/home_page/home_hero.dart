import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({
    super.key,
    required this.height,
    required this.width,
    required this.onMobile,
    required this.heroTitleString,
    required this.heroContentString,
  });

  final double height;
  final double width;
  final bool onMobile;
  final String heroTitleString;
  final String heroContentString;

  @override
  Widget build(BuildContext context) {
    if (!onMobile) {
      return SizedBox(
        width: double.infinity,
        height: height - globalAppBarHeight,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const SizedBox(
                      height: sectionGapPadding,
                    ),
                    SizedBox(
                        height: height - sectionGapPadding * 3,
                        child: Lottie.asset(
                            'assets/animation/home_hero_animation.json')),
                  ],
                )),
            DebuggingLayoutWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: sectionGapPadding,
                        ),
                        Text(
                          heroTitleString,
                          style: GoogleFonts.tinos(
                            textStyle: TextStyle(
                                fontSize: log(width * height) * 3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(
                          thickness: 5,
                          color: tenUIColor,
                        ),
                        Text(heroContentString,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: log(width * height) *
                                      3 /
                                      goldenRatio /
                                      goldenRatio,
                                  height: 2),
                            )),
                      ],
                    ),
                  ),
                  const Flexible(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            sectionGapPadding, 0, sectionGapPadding, sectionGapPadding),
        child: Column(
          children: [
            Lottie.asset('assets/animation/home_hero_animation.json'),
            const SizedBox(
              height: sectionGapPadding,
            ),
            Text(
              heroTitleString,
              style: GoogleFonts.tinos(
                textStyle: TextStyle(
                    fontSize: log(width * height) * 2,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              thickness: 3,
              color: tenUIColor,
            ),
            Text(heroContentString,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: log(width * height) * 2 / goldenRatio,
                      height: 2),
                )),
          ],
        ),
      );
    }
  }
}
