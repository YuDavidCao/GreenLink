import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_web/constants.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.height,
    required this.width,
    required this.heroTitleString,
    required this.heroContentString,
  });

  final double height;
  final double width;
  final String heroTitleString;
  final String heroContentString;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height - globalAppBarHeight,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: min(height, width / 2),
                width: min(height, width / 2),
                decoration: (globalDebuggerFlag)
                    ? BoxDecoration(border: Border.all(color: Colors.black))
                    : null,
                // height: 100,
                // width: 100,
                child: Lottie.asset('assets/animation/hero_animation.json'),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: min(height, width / 2),
                width: min(height, width / 2),
                decoration: (globalDebuggerFlag)
                    ? BoxDecoration(border: Border.all(color: Colors.black))
                    : null,
                child: Center(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
              )),
        ],
      ),
    );
  }
}
