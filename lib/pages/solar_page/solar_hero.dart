// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:GreenLink/constants.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SolarHero extends StatelessWidget {
//   const SolarHero({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.onMobile,
//     required this.heroTitleString,
//     required this.heroContentString,
//   });

//   final double height;
//   final double width;
//   final bool onMobile;
//   final String heroTitleString;
//   final String heroContentString;

//   @override
//   Widget build(BuildContext context) {
//     if (!onMobile) {
//       return SizedBox(
//         width: double.infinity,
//         height: height - globalAppBarHeight,
//         child: Stack(
//           children: [
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   height: min(height, width / 2),
//                   width: min(height, width / 2),
//                   decoration: (globalDebuggerFlag)
//                       ? BoxDecoration(border: Border.all(color: Colors.black))
//                       : null,
//                   // height: 100,
//                   // width: 100,
//                   child: Lottie.asset(
//                       'assets/animation/solar_hero_animation.json'),
//                 )),
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   height: min(height, width / 2),
//                   width: min(height, width / 2),
//                   decoration: (globalDebuggerFlag)
//                       ? BoxDecoration(border: Border.all(color: Colors.black))
//                       : null,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Flexible(
//                           flex: 2,
//                           child: SizedBox(),
//                         ),
//                         Flexible(
//                           flex: 4,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 heroTitleString,
//                                 style: GoogleFonts.tinos(
//                                   textStyle: TextStyle(
//                                       fontSize: log(width * height) * 3,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               const Divider(
//                                 thickness: 5,
//                                 color: tenUIColor,
//                               ),
//                               Text(heroContentString,
//                                   style: GoogleFonts.openSans(
//                                     textStyle: TextStyle(
//                                         fontSize: log(width * height) *
//                                             3 /
//                                             goldenRatio /
//                                             goldenRatio,
//                                         height: 2),
//                                   )),
//                               const SizedBox(
//                                 height: globalEdgePadding,
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//                                   await launchUrl(
//                                     Uri.parse(
//                                         'https://sunroof.withgoogle.com/'),
//                                     // webOnlyWindowName: isNewTab ? '_blank' : '_self',
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.fromLTRB(
//                                       globalEdgePadding,
//                                       globalMarginPadding,
//                                       globalEdgePadding,
//                                       globalMarginPadding),
//                                   decoration: BoxDecoration(
//                                       color: tenUIColor,
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(25)),
//                                       border: Border.all(
//                                           color: Colors.black, width: 2)),
//                                   child: const Text("Project Sunroof"),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Flexible(
//                           child: SizedBox(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(
//             sectionGapPadding, 0, sectionGapPadding, sectionGapPadding),
//         child: Column(
//           children: [
//             Lottie.asset('assets/animation/solar_hero_animation.json'),
//             Text(
//               heroTitleString,
//               style: GoogleFonts.tinos(
//                 textStyle: TextStyle(
//                     fontSize: log(width * height) * 2,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Divider(
//               thickness: 3,
//               color: tenUIColor,
//             ),
//             Text(heroContentString,
//                 style: GoogleFonts.openSans(
//                   textStyle: TextStyle(
//                       fontSize: log(width * height) * 2 / goldenRatio,
//                       height: 2),
//                 )),
//             const SizedBox(
//               height: globalEdgePadding,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 await launchUrl(
//                   Uri.parse('https://sunroof.withgoogle.com/'),
//                   // webOnlyWindowName: isNewTab ? '_blank' : '_self',
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(
//                     globalEdgePadding,
//                     globalMarginPadding,
//                     globalEdgePadding,
//                     globalMarginPadding),
//                 decoration: BoxDecoration(
//                     color: tenUIColor,
//                     borderRadius: const BorderRadius.all(Radius.circular(25)),
//                     border: Border.all(color: Colors.black, width: 1)),
//                 child: const Text("Project Sunroof"),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

import 'dart:math';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:GreenLink/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SolarHero extends StatelessWidget {
  const SolarHero({
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
                alignment: Alignment.centerRight,
                child: Container(
                  height: min(height, width / 2),
                  width: min(height, width / 2),
                  decoration: (globalDebuggerFlag)
                      ? BoxDecoration(border: Border.all(color: Colors.black))
                      : null,
                  // height: 100,
                  // width: 100,
                  child: Lottie.asset(
                      'assets/animation/solar_hero_animation.json'),
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
                              const SizedBox(
                                height: globalEdgePadding,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (kIsWeb) {
                                    js.context.callMethod('open',
                                        ['https://sunroof.withgoogle.com/']);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      globalEdgePadding,
                                      globalMarginPadding,
                                      globalEdgePadding,
                                      globalMarginPadding),
                                  decoration: BoxDecoration(
                                      color: tenUIColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: const Text("Project Sunroof"),
                                ),
                              ),
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
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            sectionGapPadding, 0, sectionGapPadding, sectionGapPadding),
        child: Column(
          children: [
            Lottie.asset('assets/animation/solar_hero_animation.json'),
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
            const SizedBox(
              height: globalEdgePadding,
            ),
            GestureDetector(
              onTap: () {
                if (kIsWeb) {
                  js.context
                      .callMethod('open', ['https://sunroof.withgoogle.com/']);
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                    globalEdgePadding,
                    globalMarginPadding,
                    globalEdgePadding,
                    globalMarginPadding),
                decoration: BoxDecoration(
                    color: tenUIColor,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: Colors.black, width: 1)),
                child: const Text("Project Sunroof"),
              ),
            ),
          ],
        ),
      );
    }
  }
}
