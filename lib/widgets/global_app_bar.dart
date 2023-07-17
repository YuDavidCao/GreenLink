import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';

PreferredSizeWidget globalAppBar(
    double width, bool onMobile, BuildContext context) {
  double textFontSize = (!onMobile) ? 30 : 18;
  double appBarGap = (!onMobile) ? sectionGapPadding : globalMarginPadding;
  return AppBar(
    toolbarHeight: (!onMobile) ? globalAppBarHeight : globalAppBarHeight / 2,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: width / 6,
            ),
            Text(
              "SolarGuide",
              style: TextStyle(fontSize: textFontSize, color: Colors.white),
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
              child: Text("Home",
                  style:
                      TextStyle(fontSize: textFontSize, color: Colors.white)),
            ),
            SizedBox(
              width: appBarGap,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  "/Community",
                );
              },
              child: Text("Community",
                  style:
                      TextStyle(fontSize: textFontSize, color: Colors.white)),
            ),
            SizedBox(
              width: appBarGap,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  "/Solar",
                );
              },
              child: Text("Solar",
                  style:
                      TextStyle(fontSize: textFontSize, color: Colors.white)),
            ),
            SizedBox(
              width: appBarGap,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  "/Wind",
                );
              },
              child: Text("Wind",
                  style:
                      TextStyle(fontSize: textFontSize, color: Colors.white)),
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
