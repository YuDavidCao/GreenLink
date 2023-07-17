import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/pages/solar_page/solar_hero.dart';
import 'package:solar_web/widgets/element_group_widget.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';

PreferredSizeWidget globalAppBar(
    double width, bool onMobile, BuildContext context) {
  return AppBar(
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
                  "/Home",
                );
              },
              child: const Text("Home",
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            const SizedBox(
              width: sectionGapPadding,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  "/Solar",
                );
              },
              child: const Text("Solar",
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            const SizedBox(
              width: sectionGapPadding,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  "/Wind",
                );
              },
              child: const Text("Wind",
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            SizedBox(
              width: width * 6 / 31,
            ),
          ],
        )
      ],
    ),
  );
}
