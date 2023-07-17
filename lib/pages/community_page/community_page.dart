import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/widgets/global_app_bar.dart';
import 'package:solar_web/widgets/login_widget.dart';
import 'package:solar_web/widgets/search_bar.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool onMobile = width < height;
    if (!onMobile) {
      return Scaffold(
        appBar: globalAppBar(width, onMobile, context),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox()),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  const GlobalSearchBar(),
                  const Divider(
                    thickness: 5,
                    color: tenUIColor,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [],
                      ),
                      const Divider(
                        thickness: 5,
                        color: tenUIColor,
                      ),
                      Column(
                        children: [],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Flexible(flex: 1, child: SizedBox()),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(onPressed: () {
          popupForm(context, width, height, formKey);
        }),
      );
    } else {
      return const Placeholder();
    }
  }
}
