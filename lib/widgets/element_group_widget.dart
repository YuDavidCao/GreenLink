import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/widgets/image_title_content_column.dart';

class ElementGroupWidget extends StatelessWidget {
  const ElementGroupWidget({
    super.key,
    required this.width,
    required this.height,
    required this.ratio,
    required this.onMobile,
    required this.title,
    required this.costSavingImage,
    required this.costSavingTitle,
    required this.costSavingContent,
  });

  final String title;
  final double ratio;
  final bool onMobile;
  final double width;
  final double height;
  final List<Image> costSavingImage;
  final List<String> costSavingTitle;
  final List<String> costSavingContent;

  @override
  Widget build(BuildContext context) {
    if (!onMobile) {
      return SizedBox(
        width: double.infinity,
        // height: height - globalAppBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox()),
            Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: sectionGapPadding,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.tinos(
                        textStyle: TextStyle(
                            fontSize: log(width * height) * 3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: sectionGapPadding,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...costSavingImage
                            .mapIndexed((int index, Image element) => SizedBox(
                                  width: width / ratio,
                                  child: ImageTitleContentColumn(
                                      onMobile: onMobile,
                                      width: width,
                                      height: height,
                                      ratio: ratio,
                                      image: element,
                                      title: costSavingTitle[index],
                                      content: costSavingContent[index]),
                                ))
                            .toList(),
                      ],
                    ),
                    const SizedBox(
                      height: sectionGapPadding,
                    ),
                  ],
                )),
            const Flexible(flex: 1, child: SizedBox()),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(sectionGapPadding),
        child: Column(
          children: [
            const SizedBox(
              height: sectionGapPadding,
            ),
            Text(
              title,
              style: GoogleFonts.tinos(
                textStyle: TextStyle(
                    fontSize: log(width * height) * 3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: sectionGapPadding,
            ),
            ...costSavingImage
                .mapIndexed((int index, Image element) => SizedBox(
                      width: width - sectionGapPadding * 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0, 0, 0, sectionGapPadding),
                        child: ImageTitleContentColumn(
                            onMobile: onMobile,
                            width: width,
                            height: height,
                            ratio: ratio,
                            image: element,
                            title: costSavingTitle[index],
                            content: costSavingContent[index]),
                      ),
                    ))
                .toList()
          ],
        ),
      );
    }
  }
}
