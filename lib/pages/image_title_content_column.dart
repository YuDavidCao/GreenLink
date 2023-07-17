import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';

class ImageTitleContentColumn extends StatelessWidget {
  final Image image;
  final String title;
  final String content;
  final double width;
  final double height;
  final double ratio;
  const ImageTitleContentColumn(
      {super.key,
      required this.image,
      required this.title,
      required this.content,
      required this.height,
      required this.width,
      required this.ratio});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width / ratio,
          height: width / ratio,
          child: image,
        ),
        const SizedBox(
          height: globalEdgePadding,
        ),
        Text(title,
            style: GoogleFonts.tinos(
              textStyle: TextStyle(
                  fontSize: log(width * height) * 2.5,
                  fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: globalEdgePadding,
        ),
        Text(
          content,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(fontSize: log(width * height) * 2.5 / goldenRatio),
          ),
        )
      ],
    );
  }
}
