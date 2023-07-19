import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/firebase/firebase_firestore_service.dart';
import 'package:solar_web/widgets/change_profile_info_popup.dart';
import 'package:solar_web/widgets/login_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

PreferredSizeWidget globalAppBar(
    double width, bool onMobile, BuildContext context, double height) {
  double textFontSize = (!onMobile) ? 30 : 18;
  double appBarGap = (!onMobile) ? sectionGapPadding : globalMarginPadding;
  double iconSized = (!onMobile) ? 36 : 24;
  if (kIsWeb) {
    return AppBar(
      toolbarHeight: (!onMobile) ? globalAppBarHeight : globalAppBarHeight / 2,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: (!onMobile) ? width / 6 : globalEdgePadding,
              ),
              Text(
                "GreenLink",
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
              Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        final GlobalKey<FormState> formKey =
                            GlobalKey<FormState>();
                        if (Provider.of<UserState>(context, listen: false)
                                .user ==
                            null) {
                          popupForm(context, width, height, formKey);
                        } else {
                          changeProfileInfoPopup(
                              context,
                              width,
                              height,
                              formKey,
                              await FirebaseFirestoreService.getUserName(
                                  Provider.of<UserState>(context, listen: false)
                                      .email));
                        }
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: iconSized,
                      )),
                  if (!onMobile)
                    const SizedBox(
                      height: 10,
                    ),
                ],
              ),
              SizedBox(
                width: (!onMobile) ? width / 6 : globalEdgePadding,
              ),
            ],
          )
        ],
      ),
    );
  } else {
    return AppBar(
      toolbarHeight: (!onMobile) ? globalAppBarHeight : globalAppBarHeight / 2,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: globalEdgePadding,
              ),
              Text(
                "GreenLink",
                style: TextStyle(fontSize: textFontSize, color: Colors.white),
              )
            ],
          ),
          IconButton(
              onPressed: () async {
                final GlobalKey<FormState> formKey = GlobalKey<FormState>();
                if (Provider.of<UserState>(context, listen: false).user ==
                    null) {
                  popupForm(context, width, height, formKey);
                } else {
                  changeProfileInfoPopup(
                      context,
                      width,
                      height,
                      formKey,
                      await FirebaseFirestoreService.getUserName(
                          Provider.of<UserState>(context, listen: false)
                              .email));
                }
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: iconSized,
              )),
        ],
      ),
    );
  }
}
